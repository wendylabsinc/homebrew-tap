cask "wendy-agent" do
  version "2026.04.30-211221"
  sha256 "0e155e79689608d2d2b5ecc32f75b79c3450223d2eb8c3b3443ede7af8c4ecb8"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
