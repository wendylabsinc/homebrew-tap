# Wendy Labs Tap

Enable the local pre-push check with `git config core.hooksPath .githooks`.
It runs Homebrew style, actionlint, and the release monitor tests before a push.
Install `actionlint` with `brew install actionlint` if needed. CI checks the
entire tap on every branch push before running the macOS installation tests.
An error in any formula can block every release PR.

Release validation and publishing failures post to Slack through the organization
secret `CI_SLACK_BOT_TOKEN` and variable `CI_SLACK_CHANNEL`. The hourly release
monitor also reports `pr-pull` PRs waiting over an hour and missing or mismatched
bottle assets after a one-hour build allowance. Each PR revision or bottle version
alerts once, even if both validation and publishing fail or the hourly monitor
finds it again. A successful publishing run also alerts immediately if its PR
remains open; other successful runs stay quiet. Publishing pins `brew pr-pull`
to the verified PR revision and explicitly closes the PR after pushing the
rebased commits, before deleting its branch. If closing fails, the run still
succeeds (the release is on main) and the open-PR alert fires instead.
Run `release alerts` manually to check
release health; select `test_notification` only for an explicit Slack delivery
test. Missing notification configuration fails the monitor instead of silently
skipping the alert.

```sh
brew install wendylabsinc/tap/wendy
```

To install Wendy, configure MCP integration with your AI tools, and launch the
interactive tour in one command, run this in a terminal:

```sh
brew install wendylabsinc/tap/wendy && wendy mcp setup && wendy tour
```

For nightly builds, replace `wendylabsinc/tap/wendy` with
`wendylabsinc/tap/wendy-nightly`.

MCP setup and the tour run after Homebrew finishes. Homebrew runs formula
post-install hooks in a sandbox with a temporary home directory, so those hooks
cannot configure your AI tools in your real home directory. The tour also needs
an interactive terminal. Shell completion files are installed through Homebrew.

## Local Linux containers on macOS

Wendy does not install Apple `container` as a dependency. Remote device
management does not require it. If you choose Apple `container` for local Linux
containers, install and configure it separately on an Apple Silicon Mac running
macOS Tahoe (26) or newer:

```sh
brew install container
container system start --enable-kernel-install
container run --rm alpine echo hello
container builder start
```

The startup command installs the recommended Linux kernel if needed. The
`alpine` command checks that a container can actually run; it should print
`hello`. The builder is needed for local image builds.

Run these commands in your logged-in user's terminal. If you manage the service
with `brew services` instead, install the kernel explicitly with
`container system kernel set --recommended` before running containers.
