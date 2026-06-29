cask "wendy-agent-nightly" do
  version "2026.06.29-174243"
  sha256 "7e015ee424bc9f17cb93dd801b40f1d4eab0e1bbe2aeb0b69ac08ee9218ee81d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
