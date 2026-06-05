cask "wendy-agent-nightly" do
  version "2026.06.05-165008"
  sha256 "13dc018499fb677d7d9fe189b6221a63f9c901a4ebb367793119089d966e5e83"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
