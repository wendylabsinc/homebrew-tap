cask "wendy-agent-nightly" do
  version "2026.07.23-091810"
  sha256 "e3f76b256bbd4e574d1608f93760b0d8a04a165d5d67efe9b726206b3186b1e2"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
