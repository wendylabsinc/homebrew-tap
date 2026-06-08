cask "wendy-agent-nightly" do
  version "2026.06.08-093832"
  sha256 "23569a768600152a04a25b9ba2297325dc3931ffc2319f246688b85fd681bbf3"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
