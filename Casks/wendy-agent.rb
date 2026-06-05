cask "wendy-agent" do
  version "2026.06.05-173402"
  sha256 "c8b364937ad58ec42543369f67688c83f5e489a8208e8afc2057fcdbcc135ff6"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
