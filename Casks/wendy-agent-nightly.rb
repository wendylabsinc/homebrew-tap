cask "wendy-agent-nightly" do
  version "2026.11.09-004630"
  sha256 "d84bf7efed2161a726cf3130c1f25d059c5373e1463158ff081261c5a0695bd5"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
