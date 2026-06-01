cask "wendy-agent-nightly" do
  version "2026.06.01-174701"
  sha256 "193667fdc20440bc53f0cc9341c50807ca0ecb763e108bc6e5d877b93c583f6c"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
