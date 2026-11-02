cask "wendy-agent-nightly" do
  version "2026.11.02-044019"
  sha256 "9b730cba7dad18a935c0fae0a6dd876111ddb96ff65f55d5aaee4b6bed7b645d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
