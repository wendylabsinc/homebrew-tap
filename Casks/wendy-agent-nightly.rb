cask "wendy-agent-nightly" do
  version "2026.11.12-180214"
  sha256 "31f53732d9bef72b31973603f9571ac557040ad031e5327e5462fb4f82a5ed79"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
