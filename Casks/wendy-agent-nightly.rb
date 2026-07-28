cask "wendy-agent-nightly" do
  version "2026.07.28-210415"
  sha256 "dec2f1081f21cd5d4cceabe617e275bce63b7410fcad0800384b4c2553120b5b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
