cask "wendy-agent-nightly" do
  version "2026.07.01-110957"
  sha256 "1a6a70bc49c60a42f233723e732fbc74a0d059af54e59c0295d2d9a01d52a289"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
