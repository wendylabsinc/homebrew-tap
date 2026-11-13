cask "wendy-agent" do
  version "2026.11.13-112158"
  sha256 "c7a1e8b834b8a4d6b156ad385cd2635babd6ed1df8e46e578935ebf7b6907201"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
