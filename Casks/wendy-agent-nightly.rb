cask "wendy-agent-nightly" do
  version "2026.05.03-125354"
  sha256 "dd2cfb6249978f3fb4c2cf199f81f8429b59d0c7afcde724bcdbea7d5e367d90"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
