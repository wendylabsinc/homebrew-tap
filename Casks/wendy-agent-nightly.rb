cask "wendy-agent-nightly" do
  version "2026.11.05-171924"
  sha256 "5131a0da52023701acdc20a27fb66c29e6e7a14b150316c9eb6cc32ca2dd89de"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
