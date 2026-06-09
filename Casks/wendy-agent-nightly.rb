cask "wendy-agent-nightly" do
  version "2026.06.09-141803"
  sha256 "1f00acb4325af0d10618f67c410511b4a7b183fdda5fb3ffbb5bd9632e12cbcf"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
