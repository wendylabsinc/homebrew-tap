cask "wendy-agent-nightly" do
  version "2026.04.21-133945-dev"
  sha256 "9b89eae7793d9794ac7fcad3b3bb1a2064e88615818382f0116a1504e9aec442"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Wendy Agent for macOS (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
