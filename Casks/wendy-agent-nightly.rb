cask "wendy-agent-nightly" do
  version "2026.06.04-120100"
  sha256 "826cf255b6e926022ff8dee15b0c9a18f2886717986ef25dd92bf990bb6d596f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
