cask "wendy-agent" do
  version "2026.08.15-001455"
  sha256 "6aad2636814483241d9241ccd2d9f523929355dd7808da81a314acf63d7f2504"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
