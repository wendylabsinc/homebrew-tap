cask "wendy-agent-nightly" do
  version "2026.08.05-043432"
  sha256 "9af4ac434de951eb22515844e3b88c04afbefb7dcd301816c228bc80a66d0095"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
