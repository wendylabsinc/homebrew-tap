cask "wendy-agent-nightly" do
  version "2026.10.15-052506"
  sha256 "5f6607054ec360b5ec1a439a4fcbb5e936442c7f7d7e9de6c8dfe6857fbea80f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
