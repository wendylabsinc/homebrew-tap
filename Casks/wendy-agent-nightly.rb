cask "wendy-agent-nightly" do
  version "2026.06.16-202159"
  sha256 "1df082f04437067b470114f4f6ca2d1a63c7b9991ececd904a764ceeae95ced7"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
