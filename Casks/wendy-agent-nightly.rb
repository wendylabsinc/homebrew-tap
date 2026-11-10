cask "wendy-agent-nightly" do
  version "2026.11.10-142114"
  sha256 "b38d36ef3687e8e5509d4ad51c42b1c050e021086170f763199bcf35973c4e5f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
