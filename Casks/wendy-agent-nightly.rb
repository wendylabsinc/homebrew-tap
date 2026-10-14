cask "wendy-agent-nightly" do
  version "2026.10.14-154418"
  sha256 "805f3076852fced46e652d4727e5de56d91eb9739992a861ea7a44572fa1c8d9"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
