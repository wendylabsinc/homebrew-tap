cask "wendy-agent-nightly" do
  version "2026.05.02-025508"
  sha256 "0e8c0b5125630e8ebdbfc7dad9d33f9ac2889bc0fe0c43d6a2a835b7bb378720"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
