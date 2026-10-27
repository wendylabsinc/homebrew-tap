cask "wendy-agent-nightly" do
  version "2026.10.27-102715"
  sha256 "8515f3259cd092edb50b54d676b12a21cb71cc9981f21f4bcfa5283409cdfd08"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
