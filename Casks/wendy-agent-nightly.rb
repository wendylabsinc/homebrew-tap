cask "wendy-agent-nightly" do
  version "2026.08.27-190325"
  sha256 "ff5f1d99e89d3376bf2c25ea745386cfb3a5dbd7e4e4b64049f45de67806d8cf"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
