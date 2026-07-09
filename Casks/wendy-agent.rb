cask "wendy-agent" do
  version "2026.07.09-190243"
  sha256 "5904ae6ffca5dddff892a91cb2442634c183bd1dd2a8b9102196958a20c18566"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
