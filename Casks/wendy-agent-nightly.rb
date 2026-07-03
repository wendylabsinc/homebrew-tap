cask "wendy-agent-nightly" do
  version "2026.07.03-113716"
  sha256 "bb81c5cc9be761fa88b2ad1a8360e9dc8d90b2c0d780dacbb538ab78dd6d720d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
