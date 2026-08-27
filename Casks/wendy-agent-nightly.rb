cask "wendy-agent-nightly" do
  version "2026.08.27-185201"
  sha256 "9832c87abd4666bd50f4e4a2af358fd47f07290b630ffdfdefaf6e7eaf972753"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
