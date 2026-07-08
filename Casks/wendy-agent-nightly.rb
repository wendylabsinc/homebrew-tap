cask "wendy-agent-nightly" do
  version "2026.07.08-124550"
  sha256 "7ad2de597cb87b0a34e3454948dee89213fd7a2ba99d2b84f82f4ba2dd4c3eb4"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
