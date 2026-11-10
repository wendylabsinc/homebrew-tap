cask "wendy-agent" do
  version "2026.11.10-062304"
  sha256 "f2613dba7144d62df08dda356770c95df31a1109491118234103223ef539fa59"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
