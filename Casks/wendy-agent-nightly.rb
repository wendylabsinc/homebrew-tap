cask "wendy-agent-nightly" do
  version "2026.10.16-094324"
  sha256 "8536f98bb6254f37a6c09351a8691c2077f98c0b8304acb1715320081ee1ed23"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
