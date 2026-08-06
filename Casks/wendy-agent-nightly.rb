cask "wendy-agent-nightly" do
  version "2026.08.06-232246"
  sha256 "54b41f59d9b565e7aa92b31daab1467c8660a801452566aae062f2a07be550f4"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
