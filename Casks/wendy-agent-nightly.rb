cask "wendy-agent-nightly" do
  version "2026.05.04-121659"
  sha256 "fb6b1e3c61d12a60e5217a588665d341093342665b62d19ace868d9f48c3507b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
