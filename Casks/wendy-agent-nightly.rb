cask "wendy-agent-nightly" do
  version "2026.06.08-090718"
  sha256 "144745955d71b00c9a5ff55d327478b7c8693eff74b91b056ed9abc5377fe260"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
