cask "wendy-agent-nightly" do
  version "2026.11.05-114424"
  sha256 "fbb4d81ed218582c115b0a1e19f621010281f98d2aa0b5b11cfaab112b5b8ff0"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
