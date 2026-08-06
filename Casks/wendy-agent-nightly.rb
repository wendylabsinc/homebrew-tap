cask "wendy-agent-nightly" do
  version "2026.08.06-000532"
  sha256 "9bde104b05adcde90c844628891bae68f199dea395fe3ed42439a694baf0d780"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
