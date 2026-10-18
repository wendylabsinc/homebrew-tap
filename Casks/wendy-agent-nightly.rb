cask "wendy-agent-nightly" do
  version "2026.10.18-091708"
  sha256 "2b1f5516b177748a67802fb959d55a81c426232bda62b729e85dee9626ac8a75"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
