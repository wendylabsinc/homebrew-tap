cask "wendy-agent-nightly" do
  version "2026.06.27-190538"
  sha256 "de69863c4cb890e14a163bfb985b3b5daad903bac4bcc9c2a5e3a574889122ae"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
