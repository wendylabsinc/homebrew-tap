cask "wendy-agent-nightly" do
  version "2026.06.28-211723"
  sha256 "63bdb26690d1159e866ee202153e3ada65b6ad41511bc0f45ed4edaba90e0ced"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
