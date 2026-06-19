cask "wendy-agent-nightly" do
  version "2026.06.19-121323"
  sha256 "49822656827865fe1a53ff9df2e3004028a522e24e097d08c0ba33c48d779e1e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
