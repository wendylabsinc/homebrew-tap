cask "wendy-agent-nightly" do
  version "2026.06.09-111506"
  sha256 "c5d6c6a74ee438966e5ecc79b765dc4b467cc8f1404b0b1967f61f971759d7ee"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
