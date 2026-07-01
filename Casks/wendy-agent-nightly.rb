cask "wendy-agent-nightly" do
  version "2026.07.01-213609"
  sha256 "175f847fc3c3f9a16929d1edf09b802b3cb41bd8223f3d9dcbe85ecc8be6a43c"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
