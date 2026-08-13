cask "wendy-agent-nightly" do
  version "2026.08.13-225209"
  sha256 "29f25e6fdc8ea9f8d3aa07085cea506348444da4f7c8c14ddd7cdcae2a30124a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
