cask "wendy-agent-nightly" do
  version "2026.11.14-105500"
  sha256 "3de371d0b90a311e2cf36b67f6bd09152bc080ba42939ed552bdd3d2a81350de"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
