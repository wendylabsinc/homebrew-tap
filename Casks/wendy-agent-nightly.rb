cask "wendy-agent-nightly" do
  version "2026.11.04-222608"
  sha256 "95ea0972391e56a331a61b6af7728053c83710ae8c9f5ae4906fcb12bd78fa18"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
