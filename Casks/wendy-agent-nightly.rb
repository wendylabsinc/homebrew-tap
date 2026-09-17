cask "wendy-agent-nightly" do
  version "2026.09.17-075603"
  sha256 "d1c2a79d33fd5829302b131c1920087e62dffdc730468ef9b8b650187b16d806"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
