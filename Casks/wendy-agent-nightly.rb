cask "wendy-agent-nightly" do
  version "2026.11.10-052238"
  sha256 "af5f870c03aef34c1e36a790129b621e5a2559f3564e007fafc3571734b19ea0"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
