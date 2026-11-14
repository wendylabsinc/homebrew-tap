cask "wendy-agent-nightly" do
  version "2026.11.14-134017"
  sha256 "185aff24eba2d3f54af81ff45a8ce848f01dd0bc95d4df066304e1f656916547"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
