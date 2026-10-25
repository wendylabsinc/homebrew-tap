cask "wendy-agent-nightly" do
  version "2026.10.25-172404"
  sha256 "6adee778f47510c2763030b2e9f1f0ed631c49696bac00eb9b9697ab786cb326"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
