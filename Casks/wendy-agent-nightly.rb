cask "wendy-agent-nightly" do
  version "2026.11.02-213845"
  sha256 "da89b86b3656788f0b9da3fa1ad5d4ddec7595ee933a807c1fe8d03b2bf4e269"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
