cask "wendy-agent-nightly" do
  version "2026.09.18-001929"
  sha256 "c2b3ce3b8ba876ce6eb45004164470c9968ecafd2d0cf9f919a01850c348e173"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
