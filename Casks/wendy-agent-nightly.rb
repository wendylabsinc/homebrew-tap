cask "wendy-agent-nightly" do
  version "2026.11.22-182325"
  sha256 "bb745aab731c077efed03e1c21024922f105d8904c7146e80881f3b8338c157b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
