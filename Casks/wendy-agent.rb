cask "wendy-agent" do
  version "2026.06.01-021827"
  sha256 "9eb11c84caa71013ed3e392c990245e8710b223b1a41a39b379195440926e478"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
