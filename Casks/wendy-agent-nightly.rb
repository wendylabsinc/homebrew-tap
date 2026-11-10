cask "wendy-agent-nightly" do
  version "2026.11.10-062223"
  sha256 "043654a900853b165680e89fb4207e45e100eb629774cf2652f0a2789112d99a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
