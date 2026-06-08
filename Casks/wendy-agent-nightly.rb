cask "wendy-agent-nightly" do
  version "2026.06.08-192719"
  sha256 "6653c8b36b7ffe7f78ee050d85c488bfd5639d1e320a78f85a0cf5fa4d6d231c"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
