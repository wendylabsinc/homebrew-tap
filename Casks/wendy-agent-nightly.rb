cask "wendy-agent-nightly" do
  version "2026.11.12-111515"
  sha256 "d2087d674b7148e81114ea2048d3597c0b18dec696f102d4f5259bdb485ae29d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
