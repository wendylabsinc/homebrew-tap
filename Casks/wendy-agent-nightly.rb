cask "wendy-agent-nightly" do
  version "2026.11.23-170003"
  sha256 "33cdc40a695571f905c9fbc8fbbcaf3d98968b2927e30ff08f3bc497c1013d2c"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
