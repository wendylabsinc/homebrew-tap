cask "wendy-agent-nightly" do
  version "2026.06.07-175506"
  sha256 "7b19df27c96f0295b7babed8529e0e9b2fe60764e8028601594ab740b892181c"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
