cask "wendy-agent" do
  version "2026.11.10-052256"
  sha256 "6ca89ae808a0728f0f9508a62107d91f614db1363f86d91a1357d6604c4d5b7c"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
