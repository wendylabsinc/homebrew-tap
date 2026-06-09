cask "wendy-agent" do
  version "2026.06.09-034757"
  sha256 "6650b75f0502c961fd23c511dff82a769727de42ead41c81dd04a129c22fa9f7"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
