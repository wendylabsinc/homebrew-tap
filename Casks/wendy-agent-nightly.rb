cask "wendy-agent-nightly" do
  version "2026.10.14-143232"
  sha256 "b6940977bc41bc83d83f978c3ea0aa9a4a76a9f0a2103c5c86fb459ee332adb3"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
