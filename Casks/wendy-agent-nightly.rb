cask "wendy-agent-nightly" do
  version "2026.07.21-085802"
  sha256 "854f6e79f2e723871547b79ff05df575070c64754b29078242c720d6e9ff6129"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
