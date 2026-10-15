cask "wendy-agent-nightly" do
  version "2026.10.15-164210"
  sha256 "21cfde62cdc2cc6cd2bcc4021cf4c93937de081dde25f5ba7ad3bc8b6f8533df"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
