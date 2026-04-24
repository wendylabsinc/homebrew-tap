cask "wendy-agent-nightly" do
  version "2026.04.24-094128"
  sha256 "ee82e1d63b568dcdc7db84c609827b1cadac30ea12b09eb7b8152c0b628d0e40"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
