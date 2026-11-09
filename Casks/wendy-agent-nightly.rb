cask "wendy-agent-nightly" do
  version "2026.11.09-221354"
  sha256 "52333aa6ee073c57b928a907d743f67322512a5188375b88f2d36676cb3a4c74"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
