cask "wendy-agent-nightly" do
  version "2026.10.13-182438"
  sha256 "bca856c4e759d7de90c3bb56560bf9a9577a67e20a3968766ec1a5dfc2f5758e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
