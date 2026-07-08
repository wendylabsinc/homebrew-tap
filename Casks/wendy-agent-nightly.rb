cask "wendy-agent-nightly" do
  version "2026.07.08-155315"
  sha256 "ad9885f2ed90080958d54b56e1644fa8987bba781931712b459dec2c52fb0cb1"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
