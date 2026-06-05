cask "wendy-agent-nightly" do
  version "2026.06.05-170530"
  sha256 "bb3f8f079995ea571ed47f231810c74be4291f6197e9b444278f996589d80d29"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
