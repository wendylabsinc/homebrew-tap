cask "wendy-agent-nightly" do
  version "2026.11.15-074637"
  sha256 "84b55e48ea9a6c107ebc780ee7cff899c72138ef53f27ddcb0cc8f2c9e3ae0f3"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
