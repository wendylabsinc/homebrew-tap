cask "wendy-agent-nightly" do
  version "2026.06.27-123725"
  sha256 "7499b364b857331a02e797a2c7318b19aec5e0f375bee2c1e06daafcf789f59b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
