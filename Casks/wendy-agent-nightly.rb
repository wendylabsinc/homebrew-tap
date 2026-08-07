cask "wendy-agent-nightly" do
  version "2026.08.07-160738"
  sha256 "a3819ce9cdd7e9cdc1e428690a4cbe0050d83977af2866dfb016b886cab1d435"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
