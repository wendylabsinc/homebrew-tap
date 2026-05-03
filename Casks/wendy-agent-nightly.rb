cask "wendy-agent-nightly" do
  version "2026.05.03-131605"
  sha256 "25a432517406fc651ecbc0b1cc2cc0c05d3850c73470125e6ea89eaf3ecfe1a2"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
