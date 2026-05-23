cask "wendy-agent-nightly" do
  version "2026.05.23-155555"
  sha256 "54e3164039e291d93e8fbe36156e54d3ebfb0f7c2f966bf12c3c229f005ff8d3"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
