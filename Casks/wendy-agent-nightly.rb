cask "wendy-agent-nightly" do
  version "2026.06.04-142001"
  sha256 "1080ee6b497037215fb0747bcf846c8bda7643685e6bed420a4d1bb9b32b0a22"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
