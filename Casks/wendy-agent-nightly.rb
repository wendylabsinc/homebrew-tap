cask "wendy-agent-nightly" do
  version "2026.10.20-223431"
  sha256 "21e091d6545d581f9912b11fea205c18808808e62b106fb965fd3391395b4e81"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
