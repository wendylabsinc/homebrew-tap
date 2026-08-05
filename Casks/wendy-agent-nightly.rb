cask "wendy-agent-nightly" do
  version "2026.08.05-232928"
  sha256 "8868cd958f35ef70aab7dc9cb29b81909de8d494fefee08b2822b289ab58a63f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
