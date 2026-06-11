cask "wendy-agent-nightly" do
  version "2026.06.11-153928"
  sha256 "876b45dfe6cfd8816311603db55b712d281867b41d2bb03fd7bc12f2d2451fe3"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
