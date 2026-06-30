cask "wendy-agent-nightly" do
  version "2026.06.30-075501"
  sha256 "0c95cc4cf99de4ce59788595f61f62c952c5ce19e8b462090a8570875283fa05"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
