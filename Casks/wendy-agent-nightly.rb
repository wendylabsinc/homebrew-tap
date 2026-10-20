cask "wendy-agent-nightly" do
  version "2026.10.20-092853"
  sha256 "3ebf4f7faa0a8b3642accaf2ce8d8266103b4a8430289de4ce47bee5907d34a1"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
