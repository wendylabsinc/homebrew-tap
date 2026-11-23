cask "wendy-agent-nightly" do
  version "2026.11.23-135608"
  sha256 "33fcd7d588ba6aac23bab2b48d414543e3d6bf921d41ae68bcf5a78acd7ba721"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
