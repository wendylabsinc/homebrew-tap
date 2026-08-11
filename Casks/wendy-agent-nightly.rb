cask "wendy-agent-nightly" do
  version "2026.08.11-221407"
  sha256 "2720febc61357b4712763d2b2d2291404fe24085654b05514c68481b76a3555a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
