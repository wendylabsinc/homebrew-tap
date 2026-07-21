cask "wendy-agent-nightly" do
  version "2026.07.21-131720"
  sha256 "d1913cd559a4cb1ffcf724080b7e93f6cb20063786bf2c53824a1f984b007037"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
