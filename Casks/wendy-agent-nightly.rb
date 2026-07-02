cask "wendy-agent-nightly" do
  version "2026.07.02-095903"
  sha256 "6af43452c5e91f079c5c5f451d93fd03d2da47d9090d3321c7411301a325e81f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
