cask "wendy-agent-nightly" do
  version "2026.06.20-164816"
  sha256 "85b0f2442674195f11e5607b7eb0b4742777245babb5e78e1e6252ed94a4159d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
