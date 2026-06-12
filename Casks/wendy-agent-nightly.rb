cask "wendy-agent-nightly" do
  version "2026.06.12-090136"
  sha256 "63555f6bc99092eeefb8cf47ff72116137d58f8bf6194905f1c7f3e942c44561"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
