cask "wendy-agent-nightly" do
  version "2026.06.01-023937"
  sha256 "92a86ce1b133f7df216f9ef49712e269a8faa1c1dca66fcfb46a1b73b0fb5b49"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
