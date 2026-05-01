cask "wendy-agent-nightly" do
  version "2026.05.01-020746"
  sha256 "ebc811ea48c034b203fe1fca9fc56f14c97c75942b1fcf923bf57ceb114243f6"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
