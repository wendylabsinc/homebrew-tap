cask "wendy-agent" do
  version "2026.07.02-102729"
  sha256 "a0141b7553264a6076e8925fd3b6c969b9428b208db1def9b6a593923266b494"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
