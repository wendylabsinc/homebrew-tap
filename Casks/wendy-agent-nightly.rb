cask "wendy-agent-nightly" do
  version "2026.08.30-235132"
  sha256 "979946c3684b7d7be6b8e3eb3436d2b854531621c495c159fa9e8d956ef945a6"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
