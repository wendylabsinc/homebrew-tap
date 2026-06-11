cask "wendy-agent-nightly" do
  version "2026.06.11-072354"
  sha256 "8c6440d0d34033a0707b9ff040be4ca7d6f868034d800c5e12cf55ae26d2224f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
