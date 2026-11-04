cask "wendy-agent-nightly" do
  version "2026.11.04-210608"
  sha256 "3f8cac9ecc57b24726351f143e749ab5812ba7beb1db520313fac6e72868b95e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
