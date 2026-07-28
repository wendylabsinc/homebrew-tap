cask "wendy-agent-nightly" do
  version "2026.07.28-225023"
  sha256 "7f2538a9cb5f4824b7817a4fd7c20810ce615a23f9520af79949a19b57a749d9"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
