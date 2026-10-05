cask "wendy-agent-nightly" do
  version "2026.10.05-163156"
  sha256 "4e6e0ffe628d6f81d82a3953e494d65d5144fd19742e7038222877819dea1e37"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
