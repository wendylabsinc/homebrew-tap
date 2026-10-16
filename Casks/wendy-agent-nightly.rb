cask "wendy-agent-nightly" do
  version "2026.10.16-183807"
  sha256 "d22509dcf1f69edb8b4bb38de5e5806a9de2345785d2a54edc3dfb17109b205d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
