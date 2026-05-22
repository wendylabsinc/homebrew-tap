cask "wendy-agent-nightly" do
  version "2026.05.22-182247"
  sha256 "0a43b1eb5631731d5e539b96e64341698c8c1299d44e89c2dc6e2564fb70a515"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
