cask "wendy-agent-nightly" do
  version "2026.08.10-232943"
  sha256 "48a958fc26dae0f12b4f7942ea5c12a5cdfcbee75394df88bb0660da74936213"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
