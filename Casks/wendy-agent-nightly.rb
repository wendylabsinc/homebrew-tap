cask "wendy-agent-nightly" do
  version "2026.06.22-091911"
  sha256 "eac4c05cf16f6d381d7c40a215f4cff0304166afa2bd1ed246026bc2aeffcd16"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
