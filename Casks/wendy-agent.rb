cask "wendy-agent" do
  version "2026.06.01-031953"
  sha256 "c8316b44075a91a9f851c2128b276c12229a38ed629d24687a5e180936312e5e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
