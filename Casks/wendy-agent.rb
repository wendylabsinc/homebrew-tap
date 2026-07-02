cask "wendy-agent" do
  version "2026.07.02-074747"
  sha256 "d5c3fca27c95dee5184083c48e155e69b6cfd824a7d9e8c4f4eb08d4b16dac3c"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
