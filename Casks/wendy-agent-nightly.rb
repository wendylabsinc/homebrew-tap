cask "wendy-agent-nightly" do
  version "2026.06.30-201420"
  sha256 "3f354306516cca43f2e69bb0df5ca5869f5d3d0bcf64fd4381fc0b6fea08c8ac"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
