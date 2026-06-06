cask "wendy-agent-nightly" do
  version "2026.06.06-105817"
  sha256 "e0dfee8b963a78c134821dde2188e92c6fca309e2f7a524e4ecd50bc9872b4d0"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
