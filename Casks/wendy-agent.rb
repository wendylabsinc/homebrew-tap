cask "wendy-agent" do
  version "2026.09.26-062348"
  sha256 "d65fd4ab7050d16c28c66d7dd6534e48e5b202463e1295707f4024bb57b3221e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
