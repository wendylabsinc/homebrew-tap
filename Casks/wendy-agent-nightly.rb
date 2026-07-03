cask "wendy-agent-nightly" do
  version "2026.07.03-195352"
  sha256 "691d78515e716fe3ddc6cd1a7b0f67475fd0c128fef0bdafabbfe7f44dba27fb"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
