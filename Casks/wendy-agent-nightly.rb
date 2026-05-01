cask "wendy-agent-nightly" do
  version "2026.05.01-195936"
  sha256 "39084f58966d171b8eebb792ed6621b6580c82c5d8cdbbde4b050feefcde6b46"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
