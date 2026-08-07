cask "wendy-agent-nightly" do
  version "2026.08.07-230334"
  sha256 "af77a5d4c0bba8a91f5e498a5f7e1c0888e4fb1b8ce5927fd7ad077e06980336"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
