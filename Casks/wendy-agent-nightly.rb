cask "wendy-agent-nightly" do
  version "2026.07.03-221235"
  sha256 "7c694f6b682694095df3e2b4c5abbbcda0d385f1d30028a72a92751fcdfcff52"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
