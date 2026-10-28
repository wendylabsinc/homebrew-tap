cask "wendy-agent-nightly" do
  version "2026.10.28-194803"
  sha256 "c0a33ff18f25b07c1f9171ba4f78fd56631911974cd4c4e4c5d9ececbc313cd7"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
