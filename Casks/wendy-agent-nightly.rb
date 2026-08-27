cask "wendy-agent-nightly" do
  version "2026.08.27-184236"
  sha256 "339c9e12e509894d8256539d055287f679ccb7109bced9a80ddc0029023172f7"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
