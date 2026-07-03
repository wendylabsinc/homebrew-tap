cask "wendy-agent-nightly" do
  version "2026.07.03-150117"
  sha256 "3d82a85366e16e90fe72f95159fad97bb9d453f88da5d0632e26335b91c29478"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
