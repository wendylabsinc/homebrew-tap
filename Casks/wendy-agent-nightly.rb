cask "wendy-agent-nightly" do
  version "2026.06.01-114948"
  sha256 "1e7f0a4572cb710bd197917f538035336672ffa83311b2f92a926160ff5284eb"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
