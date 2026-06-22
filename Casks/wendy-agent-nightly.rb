cask "wendy-agent-nightly" do
  version "2026.06.22-162402"
  sha256 "c3bac0ebe631f29ff94f6c7a3f3ed910209530960bca2de796505d697c2f4002"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
