cask "wendy-agent-nightly" do
  version "2026.06.28-164902"
  sha256 "ba1b97cad5f9842b6df3398e3d67d639ec35564576cacc39277c7f5ad159089a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
