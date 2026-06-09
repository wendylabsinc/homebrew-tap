cask "wendy-agent-nightly" do
  version "2026.06.09-154348"
  sha256 "8b2970e478e76c3015d8acfee698f63f57317b2506e2108214fe2e71e97a40fc"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
