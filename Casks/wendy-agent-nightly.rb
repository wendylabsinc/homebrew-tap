cask "wendy-agent-nightly" do
  version "2026.10.06-133040"
  sha256 "ceaa4ef6b41ceca7c18f5df74821995b34d40c9ad1c78217f9d43c16621d63a1"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
