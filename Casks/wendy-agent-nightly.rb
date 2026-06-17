cask "wendy-agent-nightly" do
  version "2026.06.17-211446"
  sha256 "306e4b836920f29cdac3b75a546adcc4234798645c400d7f5f89dd070ba4a134"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
