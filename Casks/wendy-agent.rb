cask "wendy-agent" do
  version "2026.10.17-123916"
  sha256 "220187d271e4ebe7d7fed7099f38f0eed7844b53298442d691a5729c07e0f942"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
