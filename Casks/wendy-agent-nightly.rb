cask "wendy-agent-nightly" do
  version "2026.10.15-192700"
  sha256 "986c7a5422444e8b48fd52a749a4964732b84e4254250356fb2758dc14bb742e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
