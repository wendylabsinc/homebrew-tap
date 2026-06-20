cask "wendy-agent-nightly" do
  version "2026.06.20-093403"
  sha256 "eeac3218adb987fe781123d3dc6c27d435a0dd5bb160687721a70b427c14869d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
