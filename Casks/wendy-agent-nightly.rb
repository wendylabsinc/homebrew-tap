cask "wendy-agent-nightly" do
  version "2026.06.25-114850"
  sha256 "6f0a6dfe6ed5768dab0bc24aa89416747c7e3392f8b5da403e70ea73a4c3c64e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
