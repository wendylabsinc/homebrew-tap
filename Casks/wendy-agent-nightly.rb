cask "wendy-agent-nightly" do
  version "2026.07.09-121839"
  sha256 "6eb785498980e79e47a2e6f148b984d9b7584b9010d8bdbd9b8e89bb1619f6ff"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
