cask "wendy-agent-nightly" do
  version "2026.06.30-095409"
  sha256 "e2ceb3379666e820562c0238f9ce34d19f06d5fa1b20b4efa56ddaa0185ba2c5"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
