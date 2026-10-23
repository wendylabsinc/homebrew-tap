cask "wendy-agent-nightly" do
  version "2026.10.23-004623"
  sha256 "2adf7098b419da30aa01fdf59e5f6afcb53fdae792ef4090d3bea0b22f08c6ec"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
