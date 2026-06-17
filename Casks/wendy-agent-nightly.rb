cask "wendy-agent-nightly" do
  version "2026.06.17-173150"
  sha256 "de8ab5c93e0f04e505713a9eaad2b1ca977fa3dcd18de757e6da9c92c523aef7"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
