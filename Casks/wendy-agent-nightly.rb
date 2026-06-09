cask "wendy-agent-nightly" do
  version "2026.06.09-145030"
  sha256 "156034149fb8ff30c7471b7b53130ca411a269cab60abbcab17b5b9f0c5a8c50"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
