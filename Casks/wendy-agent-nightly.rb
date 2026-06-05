cask "wendy-agent-nightly" do
  version "2026.06.05-172449"
  sha256 "d5213e16a57a7a58504c83ea4f2c42aedc5a7a657dcc662d6535be1500e35249"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
