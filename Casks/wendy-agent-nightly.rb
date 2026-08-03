cask "wendy-agent-nightly" do
  version "2026.08.03-183412"
  sha256 "08d6eb19eb6bc7d2ba464dc5ca81e8e14c58c3510c77462662cbc2f82d3842ac"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
