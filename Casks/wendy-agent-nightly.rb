cask "wendy-agent-nightly" do
  version "2026.05.04-111922"
  sha256 "83babfcca5163bca4c761978d84556a76086ab98882d19633fc0ffd6d617b70d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
