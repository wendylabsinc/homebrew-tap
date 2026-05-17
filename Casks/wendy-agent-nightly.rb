cask "wendy-agent-nightly" do
  version "2026.05.17-182148"
  sha256 "7e83b2da91857f3bf15e04daca6cc9c132d57cfb5b09a1306016d101069ed897"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
