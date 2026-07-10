cask "wendy-agent" do
  version "2026.07.10-175233"
  sha256 "6f79d11d352cf4540a87fc15fa4858ed31ad9cd592629f84f913ebd3026ec34e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
