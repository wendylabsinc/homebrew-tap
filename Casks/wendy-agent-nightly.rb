cask "wendy-agent-nightly" do
  version "2026.07.09-202320"
  sha256 "c2f64205190a1b4452e5cc27f173b9c02dbf8a182b6b076ab605b2cf0bd44b5e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
