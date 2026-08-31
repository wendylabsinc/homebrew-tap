cask "wendy-agent-nightly" do
  version "2026.08.31-030916"
  sha256 "bed779e2ccb3886fc934bb8613eb1be5831ab49745c8e5228a7802493d4b27a6"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
