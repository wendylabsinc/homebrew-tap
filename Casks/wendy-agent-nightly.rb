cask "wendy-agent-nightly" do
  version "2026.10.22-221605"
  sha256 "62990e53fbbb81e5dbc05a1f7256e7181762eac9c3933697053c741a8e6f7088"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
