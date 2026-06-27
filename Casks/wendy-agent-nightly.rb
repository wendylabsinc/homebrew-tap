cask "wendy-agent-nightly" do
  version "2026.06.27-221534"
  sha256 "af32a6d1b1112caed61f5317dbbc26cffcb5e93efcd8a25eba1312cb67418a26"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
