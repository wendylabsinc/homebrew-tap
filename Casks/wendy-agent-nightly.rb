cask "wendy-agent-nightly" do
  version "2026.10.24-184532"
  sha256 "1b57f18849f372b009184f58cb18ed10d97dd2ff7ab28e39dec28a85ca45829b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
