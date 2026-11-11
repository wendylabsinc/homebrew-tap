cask "wendy-agent-nightly" do
  version "2026.11.11-113201"
  sha256 "1bc43295a3033a874044b27ea2c33686abea524ea79bc8b8ae8cdb7d6d972cf7"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
