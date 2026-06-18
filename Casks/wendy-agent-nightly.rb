cask "wendy-agent-nightly" do
  version "2026.06.18-203258"
  sha256 "336babc1e5857576f25cb19cdce2dfb9f5825f3fb12ff8e6afab8c91d29c7842"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
