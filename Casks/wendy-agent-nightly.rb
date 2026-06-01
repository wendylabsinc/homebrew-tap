cask "wendy-agent-nightly" do
  version "2026.06.01-025237"
  sha256 "b2556affd3cf97482c7bf8c6969be102e44a48a2b2e4ec4fcef1f96b0db385e5"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
