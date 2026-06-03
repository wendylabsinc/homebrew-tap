cask "wendy-agent-nightly" do
  version "2026.06.03-075005"
  sha256 "72cfa3c2c202038ca2c2353e55056e8ef2feffb3ab600f975df9fed07e4cb73a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
