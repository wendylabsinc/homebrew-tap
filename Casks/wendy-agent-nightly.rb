cask "wendy-agent-nightly" do
  version "2026.06.27-214307"
  sha256 "0fddf7266218e7a49310233f41d8fbddf035cfbd45a33be36c767ed6909bfab4"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
