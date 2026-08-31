cask "wendy-agent-nightly" do
  version "2026.08.31-001706"
  sha256 "7275c7e6b281965b0012060098c0a8ce4cb61c3ddd3499a245eb3b6aa4ae07d0"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
