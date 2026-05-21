cask "wendy-agent-nightly" do
  version "2026.05.21-160444"
  sha256 "505ef3d219c4d5339c5dba7c45e4a2ad38b0fd34c4401f10a37c109845c5b064"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
