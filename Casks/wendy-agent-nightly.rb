cask "wendy-agent-nightly" do
  version "2026.05.12-153510"
  sha256 "248d9ed19bb3f5a737d11ae93d20b30ce31f3e1889fa0ad532d3b503386bc334"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
