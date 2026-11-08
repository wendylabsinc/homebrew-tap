cask "wendy-agent-nightly" do
  version "2026.11.08-224654"
  sha256 "a6fa59e62537b7d93936c3c8000c0b33e5cfcf8e7d0f5c06463d1b0f9c815c2c"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
