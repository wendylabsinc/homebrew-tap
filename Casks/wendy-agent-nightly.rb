cask "wendy-agent-nightly" do
  version "2026.10.13-092234"
  sha256 "6f78beb26b8b836dc94fdd319221efe119b1e7e7979596f1c6e8beb2addec77a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
