cask "wendy-agent-nightly" do
  version "2026.06.05-154748"
  sha256 "2396eafce5ec9a87077c97ae81ee835d385575e6238d04bdf372b10dd0b17914"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
