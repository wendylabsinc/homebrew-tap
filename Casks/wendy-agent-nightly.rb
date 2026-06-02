cask "wendy-agent-nightly" do
  version "2026.06.02-091529"
  sha256 "44610475446329b966f664eeb2f3d7ebba9fd778b56f44069c76d0a7b6117d0a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
