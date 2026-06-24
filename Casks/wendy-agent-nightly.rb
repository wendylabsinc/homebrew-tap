cask "wendy-agent-nightly" do
  version "2026.06.24-153556"
  sha256 "8ece11ffbb616fdd1b3d415cb6bbd404930bae68c4c011411f21b29b98aac0eb"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
