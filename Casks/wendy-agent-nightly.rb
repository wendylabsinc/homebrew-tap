cask "wendy-agent-nightly" do
  version "2026.06.03-055659"
  sha256 "0e79095f3faa0a97275b7ca15c25035a3515fdac9147bc30cc667b201c5db26c"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
