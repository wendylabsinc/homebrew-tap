cask "wendy-agent-nightly" do
  version "2026.07.10-181321"
  sha256 "c85253ce1fb809d2aa2082044e25873c41c07663df6b8cca3ced205a893d8ae0"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
