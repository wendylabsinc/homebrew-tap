cask "wendy-agent-nightly" do
  version "2026.06.18-074815"
  sha256 "e66ee1617fd8f20e71b09ad94ef1f3bb363726054ea0e58c95f1aefe2563e2c8"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
