cask "wendy-agent" do
  version "2026.09.27-215032"
  sha256 "8d46bc07f332be149d52f3ba135ee5ddc0642d2a77ff9576c51a54e3585789b5"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
