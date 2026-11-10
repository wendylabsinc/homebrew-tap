cask "wendy-agent-nightly" do
  version "2026.11.10-213629"
  sha256 "3da54f9ca005b6c52c09c24dc5723f9200aafc1f817cfce1097acff296eabf89"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
