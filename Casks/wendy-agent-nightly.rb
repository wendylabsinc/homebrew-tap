cask "wendy-agent-nightly" do
  version "2026.10.22-080351"
  sha256 "6a42f8ba1743aca60ad47fd80610b67a0d6c8d68b9e61bab6aa33bf34e60df70"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
