cask "wendy-agent-nightly" do
  version "2026.11.15-164918"
  sha256 "443f61c4a215017f3d7bd3fe5eb15c4a0e91f2ba7b7cfca06af776c8a2be6e7f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
