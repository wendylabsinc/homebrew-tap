cask "wendy-agent-nightly" do
  version "2026.06.27-220113"
  sha256 "1ba96bb7c93314d095f29e8322b5cc1e4ea633a1e54132adb5666433a7b9c966"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
