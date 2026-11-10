cask "wendy-agent-nightly" do
  version "2026.11.10-023458"
  sha256 "0659b4127a19fb2ade830e6678384b92595772ede69997d02a1a2584150400ed"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
