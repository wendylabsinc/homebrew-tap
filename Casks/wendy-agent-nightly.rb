cask "wendy-agent-nightly" do
  version "2026.08.07-013337"
  sha256 "94bf205e56cbe86725f49242b85fe3ff45e76779803dc8935f5f39b70b91d685"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
