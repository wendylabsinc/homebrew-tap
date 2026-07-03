cask "wendy-agent-nightly" do
  version "2026.07.03-202241"
  sha256 "90047a6c469577e1218d957c74d3d08f04e223240a445827d42c0638357df002"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
