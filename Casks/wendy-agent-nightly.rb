cask "wendy-agent-nightly" do
  version "2026.06.04-083856"
  sha256 "afa6e13843bc532c173cb8ef46b28e81f7672aa1a5c0909efe05a2ae27582736"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
