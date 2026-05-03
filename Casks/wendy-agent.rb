cask "wendy-agent" do
  version "2026.05.03-215349"
  sha256 "04258d3a35aa64935ffb5b378391851b8faa4a069c48d014d53d249257e2dc4a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
