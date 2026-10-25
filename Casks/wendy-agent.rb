cask "wendy-agent" do
  version "2026.10.25-172412"
  sha256 "bd83187deb2660cd447e1b2f1b6e2b5d94d3be4792ca5cc86adc8180a8ed0eb6"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
