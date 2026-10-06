cask "wendy-agent-nightly" do
  version "2026.10.06-094222"
  sha256 "14cd38c9ffc48ebffe64fc9c32243f7af59af8b469b43cb3a9baeaa79083f3a6"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
