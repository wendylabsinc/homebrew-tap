cask "wendy-agent-nightly" do
  version "2026.07.03-152658"
  sha256 "a3c15ac4a7646fe8f58ed56d3d3f017d5b2dd188fc0f074695d23a5d877e7a41"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
