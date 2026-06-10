cask "wendy-agent-nightly" do
  version "2026.06.10-184823"
  sha256 "4b6daa283d22fe39ba31a315cfe99f9449bddfdb55b2cd2dbda271b88791d407"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
