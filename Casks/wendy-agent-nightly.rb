cask "wendy-agent-nightly" do
  version "2026.06.18-145157"
  sha256 "839d4ab83c156fdfd3013e6e3cf033c991efc02c411bd0b03babab482e71c901"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
