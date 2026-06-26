cask "wendy-agent-nightly" do
  version "2026.06.26-085615"
  sha256 "de0f594940e3167bb03f146ffcbb5271639a503899409a66551f23a24287f344"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
