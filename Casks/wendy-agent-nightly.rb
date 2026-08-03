cask "wendy-agent-nightly" do
  version "2026.08.03-005734"
  sha256 "8056f276b98e8db104b777ae4bd1bbcc7c5521bfe0eec815d4c80b124aa2de0b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
