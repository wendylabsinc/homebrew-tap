cask "wendy-agent-nightly" do
  version "2026.08.05-155539"
  sha256 "d2bcc6c42402d171b6116a130e0314cd5376a1d8c1c35878cc652bb1c5f846ca"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
