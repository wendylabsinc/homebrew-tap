cask "wendy-agent-nightly" do
  version "2026.11.10-231550"
  sha256 "9b91dfd8e034956ec7dc5f21cb6eeba3688d3f640a2078d9c0d836cea486e29b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
