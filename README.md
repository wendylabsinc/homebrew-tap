# Wendy Labs Tap

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
