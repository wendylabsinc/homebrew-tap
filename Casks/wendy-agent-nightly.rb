cask "wendy-agent-nightly" do
  version "2026.05.31-085126"
  sha256 "1c5a4288904588f714d9be3f067653defb57477679254c5443c1ab89c6da2ff4"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
