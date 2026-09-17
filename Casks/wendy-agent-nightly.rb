cask "wendy-agent-nightly" do
  version "2026.09.17-134711"
  sha256 "952de552cd296a5fca765f26b674758916e8200635426d1262a0c672912a2a5e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
