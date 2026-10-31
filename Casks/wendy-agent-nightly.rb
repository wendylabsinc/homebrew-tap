cask "wendy-agent-nightly" do
  version "2026.10.31-145439"
  sha256 "fc4c0f3b6ab34fb4e2e8fffce8d5a962b720b53907820def5b4b4c659c1a5156"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
