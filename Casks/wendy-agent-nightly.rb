cask "wendy-agent-nightly" do
  version "2026.05.26-195618"
  sha256 "0def7166fcdc57dbaf58caee8d704c4c87c92b36afab4f65ddc682a9f5613ecb"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
