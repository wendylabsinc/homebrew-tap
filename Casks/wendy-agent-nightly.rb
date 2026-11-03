cask "wendy-agent-nightly" do
  version "2026.11.03-103739"
  sha256 "1eeb6550d3c16295603d1ac8cfa13cf3f09b3dbf7804ca55d6ccdc5baf48379f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
