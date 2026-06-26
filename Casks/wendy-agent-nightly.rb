cask "wendy-agent-nightly" do
  version "2026.06.26-080245"
  sha256 "6e256473d78293d8f7ab1ea9ec98cce3e9f96caf25b9b5f03308b0f104a11951"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
