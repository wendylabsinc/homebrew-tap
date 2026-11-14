cask "wendy-agent-nightly" do
  version "2026.11.14-210240"
  sha256 "699239a461605de3235b4402966f0b0b41c3c75a281d4fc183695fc30933f7c5"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
