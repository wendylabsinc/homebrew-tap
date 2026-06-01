cask "wendy-agent" do
  version "2026.06.01-033236"
  sha256 "53da3507c106d328186a60dee62af800de266174e46b2750e6ec2f639a4d9b85"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
