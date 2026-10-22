cask "wendy-agent-nightly" do
  version "2026.10.22-211023"
  sha256 "2c83bc13723fac688b2ef0928fa02a89e819a16df353ffbed15ab3c1bdd43266"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
