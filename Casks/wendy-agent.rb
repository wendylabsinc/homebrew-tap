cask "wendy-agent" do
  version "2026.06.28-175635"
  sha256 "d609be821f4bbaa0019a264e21c21ee45eb4d5e917219460d48469eec231d7aa"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
