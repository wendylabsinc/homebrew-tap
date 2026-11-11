cask "wendy-agent-nightly" do
  version "2026.11.11-182439"
  sha256 "3f214dc55f33335e99f0b98c1defc80a9e9bd3753a9109dc00641e17c7b64a45"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
