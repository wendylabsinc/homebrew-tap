cask "wendy-agent-nightly" do
  version "2026.11.23-044909"
  sha256 "64416116228124eeebb614b7253cc329eab7c32051088b00d36d8327a6f1cc3b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
