cask "wendy-agent-nightly" do
  version "2026.11.13-162211"
  sha256 "0c91e7d003b1a153699fd1f395993fef66a6db484a5da0c30b2522cc2092aef0"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
