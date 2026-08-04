cask "wendy-agent-nightly" do
  version "2026.08.04-234603"
  sha256 "d23c65c7add16af1f3d5acbfb90b4f61a9c283fea5fbc1e47aabe3645e406dfe"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
