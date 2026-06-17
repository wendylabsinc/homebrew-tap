cask "wendy-agent" do
  version "2026.06.17-194156"
  sha256 "16e30291ac738da8895e3e04c5047116abc132c27e608053c23e917c01978850"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
