cask "wendy-agent" do
  version "2026.08.22-032001"
  sha256 "97704854429d71a1d4140ef43165a47d646e1bf974f4db405d51d344c5a671ab"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
