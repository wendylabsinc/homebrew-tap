cask "wendy-agent-nightly" do
  version "2026.10.17-124650"
  sha256 "f7059e31a04d1ef996494d759e52cf0ada2e4b2f39488d19ff8d4f76cae88221"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
