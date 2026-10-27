cask "wendy-agent" do
  version "2026.10.27-091653"
  sha256 "f8a3327320495bd1182ecc1716a1f0ad1c03c8d99fffeaf2c0bc9f9f7f44412f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
