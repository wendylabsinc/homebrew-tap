cask "wendy-agent-nightly" do
  version "2026.10.14-193044"
  sha256 "103eb3d108f6e94a0ccf3c13bd58641198aef0b26c5c081f5940f1ac2d7cc9e1"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
