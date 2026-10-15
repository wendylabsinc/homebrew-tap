cask "wendy-agent-nightly" do
  version "2026.10.15-095556"
  sha256 "243b21004b0cdf6affd9575a8fbcf46448e003d29baef1260d6f17c751f6ad2a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
