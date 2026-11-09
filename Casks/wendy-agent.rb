cask "wendy-agent" do
  version "2026.11.09-003350"
  sha256 "9cdb874b0636f5739fb2e16c3910113447cbb22d17c5d14b15e822092fba3138"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
