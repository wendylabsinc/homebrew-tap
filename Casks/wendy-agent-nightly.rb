cask "wendy-agent-nightly" do
  version "2026.05.15-191737"
  sha256 "e4a464aa9f90c00b4f0e034b3fe39cf84951b8a815ace9a093b43534419e2924"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
