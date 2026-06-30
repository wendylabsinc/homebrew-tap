cask "wendy-agent-nightly" do
  version "2026.06.30-214908"
  sha256 "3ef45d8d8ac25cb9a25371049891dac7099809afcf3809877a879a4b056878ee"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
