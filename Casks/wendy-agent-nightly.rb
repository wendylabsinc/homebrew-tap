cask "wendy-agent-nightly" do
  version "2026.05.12-094558"
  sha256 "9434bef74e9479e68c15133466eceb8c21eaa15a5931bba6f11e43c5754c8b24"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
