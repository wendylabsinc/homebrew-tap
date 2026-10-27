cask "wendy-agent-nightly" do
  version "2026.10.27-220350"
  sha256 "fb4dbd8279b672ed87d2c68ce45e19ce558f16e972c2b12d3b77af020d804fe4"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
