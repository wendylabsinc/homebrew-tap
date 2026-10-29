cask "wendy-agent-nightly" do
  version "2026.10.29-210822"
  sha256 "06e983790822f54cf697ba3223d6565f5b101e26f2a370fff03cd604ca8db166"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
