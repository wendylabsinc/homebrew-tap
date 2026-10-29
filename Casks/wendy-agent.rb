cask "wendy-agent" do
  version "2026.10.29-210857"
  sha256 "fada7a17255e6d5573c0e83ca582bd0b4756dd6771ee2b446d959ade8df1011a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
