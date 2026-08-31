cask "wendy-agent-nightly" do
  version "2026.08.31-061402"
  sha256 "0374a852f4eafb484e2ac74dfbcedc3a912b22a2daba8c3e0dea4f05ca06826a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
