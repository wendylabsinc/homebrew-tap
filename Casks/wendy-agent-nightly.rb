cask "wendy-agent-nightly" do
  version "2026.08.07-000710"
  sha256 "4c1dcb1a3cd5f5f5b72dc61e13db8a6ac448efc6813b81191452608fa1f2781f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
