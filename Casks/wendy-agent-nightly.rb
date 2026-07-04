cask "wendy-agent-nightly" do
  version "2026.07.04-152229"
  sha256 "0d0832f4b02354978008ba9723ba13c1277da4df18403b53268892f664f457ca"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
