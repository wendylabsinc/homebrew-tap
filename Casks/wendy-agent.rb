cask "wendy-agent" do
  version "2026.11.09-233238"
  sha256 "b8fe782f3ad8416424ca3f7d421f23d8bc0cc865540bb594779ff01fade6ad10"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
