cask "wendy-agent-nightly" do
  version "2026.08.27-210119"
  sha256 "0cf1bd5dd9593e15ce0f68b769eb4b6650614fdcc58eae36082386bd79c41e8d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
