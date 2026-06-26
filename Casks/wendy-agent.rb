cask "wendy-agent" do
  version "2026.06.26-130116"
  sha256 "9cbe69e2e7522b56cb9976255bd6121d1ffd495a41bedb3e7ca373f5be3361c7"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
