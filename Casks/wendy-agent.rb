cask "wendy-agent" do
  version "2026.06.30-170221"
  sha256 "39dc97d44d94f3364b9f9038089d70745428d96c098b2f64b616153a6b718630"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
