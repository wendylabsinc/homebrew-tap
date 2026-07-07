cask "wendy-agent-nightly" do
  version "2026.07.07-113719"
  sha256 "3fdebe284c79454ea4e6488f1cb8f1e3202ab64c639ceff70292374a0b478ba7"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
