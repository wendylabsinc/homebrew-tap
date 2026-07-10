cask "wendy-agent-nightly" do
  version "2026.07.10-214035"
  sha256 "1475906e55359e3f3fca0f5d056ebab50a7a607bc80c8a21eba5b500843c0b72"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
