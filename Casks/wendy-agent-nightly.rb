cask "wendy-agent-nightly" do
  version "2026.06.27-150914"
  sha256 "738725abd38f8a1b98fe557c58f3fb1eb76ac047512e13952b2e00c8c11d4cab"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
