cask "wendy-agent-nightly" do
  version "2026.10.26-230655"
  sha256 "2bca49e103037e18156fd0734248b8b81f49e1f5aec5ce66fde1da4a5d32a613"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
