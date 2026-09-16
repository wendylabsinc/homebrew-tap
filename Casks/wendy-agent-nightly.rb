cask "wendy-agent-nightly" do
  version "2026.09.16-215446"
  sha256 "9e8441ed03d64bac6578ca080e9bb2a7df4e170dd38d4912fc9f36107f69a7f4"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
