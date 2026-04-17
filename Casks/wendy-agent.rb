cask "wendy-agent" do
  version "2026.04.17-073307"

  # Placeholder until wendy-agent starts publishing the macOS app zip.
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-universal-#{version}.zip"
  name "Wendy Agent"
  desc "Wendy Agent for macOS"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "Wendy Agent.app"
end
