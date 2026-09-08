cask "wendy-agent" do
  version "2026.09.08-183032"
  sha256 "7a96a9e237b07b20b93815dde6f892685c1473d6c355abfddfc6647b577599e8"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
