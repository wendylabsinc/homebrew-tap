cask "wendy-agent-nightly" do
  version "2026.11.13-191841"
  sha256 "c9f9584251e2b26ac326f18529683e8c2ef72db4c24aa2828c679c5616a0a571"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
