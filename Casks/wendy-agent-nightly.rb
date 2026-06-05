cask "wendy-agent-nightly" do
  version "2026.06.05-103225"
  sha256 "e06c3a88a3ccc90524b8a060662453e1f827a51360f9e30980b6ebe7c57ad6ac"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
