# Prompt / auto-install Apple `container` on macOS hosts

**Date:** 2026-06-28
**Status:** Approved design

## Problem

The `wendy` CLI runs Linux containers locally on macOS via Apple's `container`
tool (lightweight VMs). When a user installs `wendy` on macOS but does not have
`container` installed (or its service started), local container workflows fail
with no guidance. We want macOS hosts to get `container` set up with minimal
friction, while not forcing a ~330MB download on users who only manage remote
devices.

## Background

- Apple `container` is distributed as a **homebrew-core formula** (`container`,
  v1.0.0, ~330MB), not a cask. It requires Apple Silicon and macOS 15+.
- The `wendy` macOS bottle is built for `arm64_tahoe` (macOS 26) only, so any
  macOS host installing `wendy` already satisfies `container`'s requirements.
- This repo (`homebrew-tap`) contains the formulas `Formula/wendy.rb` and
  `Formula/wendy-nightly.rb`, which are structurally identical (prebuilt-binary
  formulas with a `bottle do` block).
- The `wendy` CLI source lives in the separate `wendy-agent` repo
  (github.com/wendylabsinc/wendy-agent), which is **not** checked out in this
  workspace in editable form.

## Scope

The solution has two parts, in two repos:

1. **Formula (this repo, implement now):** make Apple `container` a *recommended*
   dependency on macOS and document it via caveats.
2. **CLI runtime net (`wendy-agent`, spec only here):** the `wendy` binary
   detects a missing/stopped `container` at runtime and offers to install/start
   it on-demand. Implemented in a separate PR in `wendy-agent`.

## Part 1 — Homebrew formula (this repo)

Apply the same change to both `Formula/wendy.rb` and `Formula/wendy-nightly.rb`.

### Dependency

Add a macOS-guarded recommended dependency:

```ruby
on_macos do
  depends_on "container" => :recommended
end
```

Behavior:

- **Default install** (`brew install wendylabsinc/tap/wendy`): pours the bottle
  and installs `container` alongside it. Recommended dependencies are installed
  when pouring a bottle.
- **Opt out** (`brew install --without-container wendylabsinc/tap/wendy`): the
  `--without-` flag forces Homebrew to ignore the bottle and "build from
  source." For these formulas, the `install` method simply re-downloads and
  copies the same prebuilt binary, so the result is identical apart from
  `container` being skipped.
- **Linux:** the `on_macos` guard means no dependency is added.

### Caveats

Extend the existing `caveats` heredoc with a macOS-only note. Use a runtime
`on_macos`/`OS.mac?` check so the note only appears on macOS:

- Local containers require Apple `container` (installed by default with this
  formula).
- You may need to run `container system start` once before first use.
- To skip the dependency, reinstall with `--without-container`.

Keep the existing analytics and `wendy mcp setup` text unchanged.

### Risk / fallback

Homebrew is gradually phasing out `:recommended` and build options. In a
third-party tap they still function (possibly with a deprecation warning). If
Homebrew tooling ever rejects options on this tap, the fallback is:

- Drop the dependency to **caveat-only** (a printed `brew install container`
  suggestion), and
- Rely on the Part 2 CLI runtime net to install on-demand.

## Part 2 — CLI runtime net (`wendyos` repo)

**Status: implemented** in the `wendylabsinc/wendyos` repo (the `wendy-agent`
source) on branch `jo/apple-container-autoinstall`. The logic lives in the
Apple Container provider's `CheckRequirements`:

- `go/internal/cli/providers/apple_container_setup.go` — install + service-start
  helpers and the stubbable seams.
- `go/internal/cli/providers/apple_container.go` — `CheckRequirements` now calls
  those helpers (install check → version → ensure `system` then `builder`).
- `go/internal/cli/providers/apple_container_setup_test.go` — unit tests for the
  install/start/decline/non-interactive branches and brew discovery.

Behavior, when a command needs the local container runtime (e.g. running or
building a container locally), on macOS:

1. **Check presence:** is `container` on `PATH`?
   - **Missing + interactive TTY:** prompt
     `Apple container is required for local containers. Install via 'brew install container'? [Y/n]`
     and run the install on confirmation.
   - **Missing + non-interactive (e.g. CI):** print an actionable error
     (the exact `brew install container` command) and exit non-zero. Do not
     attempt an unattended install.
2. **Check services (also when `container` is already installed):** Apple
   `container` has two services that must be running before local workflows
   work:
   - the system/API service — `container system start`
   - the image builder — `container builder start`

   Detect whether each is running (e.g. probe `container system status` /
   `container builder status`, or attempt the operation and catch the
   "not running" error). For each that is stopped:
   - **Interactive TTY:** prompt
     `Apple container's <service> is not running. Start it now ('container <service> start')? [Y/n]`
     and run the start command on confirmation.
   - **Non-interactive:** print the exact start command(s) and exit non-zero.

   These start prompts run on every relevant invocation when the service is
   down, independent of whether we just installed `container` or it was already
   present — so an existing install with stopped services still gets prompted.
3. **Gate on `brew`:** if `brew` is not on `PATH`, do not attempt to run the
   install. Print manual install instructions pointing at
   https://apple.github.io/container/ instead. (The `container <service> start`
   commands do not depend on `brew`.)

Non-goals for Part 2: managing `container` upgrades, configuring it beyond
starting the system and builder services, or any behavior on Linux.

## Testing

- **Formula:** `brew style` / `brew audit --strict` on both formulas; a local
  `brew install` of the formula on a macOS host to confirm `container` is pulled
  in and the caveat renders. The existing `test do` block (runs `wendy --help`)
  stays unchanged.
- **CLI runtime (in `wendy-agent`):** unit tests around the detection/branching
  logic (present/missing, TTY/non-TTY, brew present/absent), covered in that
  repo's PR.

## Out of scope

- Implementing the Part 2 CLI changes in this session (different repo, not
  checked out).
- Any Linux or Intel-mac behavior.
- Bundling or vendoring `container` itself.
