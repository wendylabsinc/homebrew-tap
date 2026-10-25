cask "wendy-agent-nightly" do
  version "2026.10.25-191059"
  sha256 "6871f496fa95d8f27189181c873fd724eeafb397f433ca4d6d7f267c325a1cd1"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
