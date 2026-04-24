cask "wendy-agent" do
  version "2026.04.24-131348"
  sha256 "67c02bae0dd5260e0775ff18c4bed0b3d3fd640ed322485cda48a1c7c0083fef"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless Mac"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
