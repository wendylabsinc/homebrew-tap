cask "wendy-agent-nightly" do
  version "2026.11.04-072939"
  sha256 "9a55b3ca584fca0bafef280a679baac732fa1182cbb9f54ff9a492a3217f818b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
