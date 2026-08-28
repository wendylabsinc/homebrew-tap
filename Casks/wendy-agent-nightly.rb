cask "wendy-agent-nightly" do
  version "2026.08.28-075409"
  sha256 "859df46a0d44a7ada96db6d14052386356864ec9346a40779620bb0c9e1e5abc"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
