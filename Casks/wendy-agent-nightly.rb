cask "wendy-agent-nightly" do
  version "2026.06.10-074902"
  sha256 "cc3d127821c5374e1f6044edffbce54043c682f321842ff4717535dfef894253"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
