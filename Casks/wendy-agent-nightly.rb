cask "wendy-agent-nightly" do
  version "2026.11.02-233104"
  sha256 "4977c542e8be713523aeda1b1a2da38518467ec3af4f2faef2a5188746e61b3b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
