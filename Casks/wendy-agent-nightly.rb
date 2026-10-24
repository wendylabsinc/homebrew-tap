cask "wendy-agent-nightly" do
  version "2026.10.24-151842"
  sha256 "f0fb230444ed7f8a4582239ca276912b60d12e32b50d93afa6afa33f86e38b02"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
