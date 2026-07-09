cask "wendy-agent-nightly" do
  version "2026.07.09-084500"
  sha256 "e79be37bdd3dbfd94609284ba1abeb1e9c061d901f5933ad0ba0aee542e6dead"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
