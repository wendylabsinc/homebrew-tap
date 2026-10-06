cask "wendy-agent-nightly" do
  version "2026.10.06-175000"
  sha256 "8e2f10e18dfaebbb5221e5b1de6176913aa69ad8abba2d3880f5b44147479950"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
