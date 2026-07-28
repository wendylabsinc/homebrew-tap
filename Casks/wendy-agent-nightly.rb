cask "wendy-agent-nightly" do
  version "2026.07.28-183852"
  sha256 "cab7ac19292cb0255ff7d2cfa7e2a43139d4039c57d78b3ca1f64698bb0b0ecb"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
