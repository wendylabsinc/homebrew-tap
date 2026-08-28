cask "wendy-agent-nightly" do
  version "2026.08.28-152617"
  sha256 "521bc69a0fa4aea34a5126fe4f0bf7eb5ea038b7e380344ed41dd5d86bc03ed7"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
