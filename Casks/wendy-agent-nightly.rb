cask "wendy-agent-nightly" do
  version "2026.11.06-165511"
  sha256 "257c9d6eb89949821652649f7761cda130cd009fff48b651527609e387552a95"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
