cask "wendy-agent-nightly" do
  version "2026.10.27-225821"
  sha256 "82c9bd98c41af0458916734150a777b7d0093820830f3e589ae4559eb9253092"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
