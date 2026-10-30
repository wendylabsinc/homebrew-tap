cask "wendy-agent-nightly" do
  version "2026.10.30-170423"
  sha256 "424832bec61103ce04945698b6b0c9596c0dbaeb6f2c72b05796577fc0e359ab"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
