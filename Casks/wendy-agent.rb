cask "wendy-agent" do
  version "2026.09.16-025644"
  sha256 "04174856ed0842ba6f74b360211dbe29a12acd9945519af6b194c03e15ddc92b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
