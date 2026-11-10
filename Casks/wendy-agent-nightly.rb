cask "wendy-agent-nightly" do
  version "2026.11.10-170330"
  sha256 "9f94bb459d6ddf0735c872e1ad5578a20b82d09ce13e36321692c15d29dc28c5"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
