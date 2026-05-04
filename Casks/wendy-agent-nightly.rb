cask "wendy-agent-nightly" do
  version "2026.05.04-130056"
  sha256 "c7a3392762ea996af38da4e65270a6dabd72417ce6db9cc5d1db540938c9aa01"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
