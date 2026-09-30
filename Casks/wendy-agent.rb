cask "wendy-agent" do
  version "2026.09.30-213433"
  sha256 "228804c2ef0872dd4b856444124dfe4b46b3828cbe0b239af2b1180ff51d0572"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
