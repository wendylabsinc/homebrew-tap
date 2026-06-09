cask "wendy-agent-nightly" do
  version "2026.06.09-072805"
  sha256 "35a90c58c1bc30deb00ff194677eaae2e6c10891598f77f3f53ad549919404ab"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
