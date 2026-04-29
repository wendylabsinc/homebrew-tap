cask "wendy-agent" do
  version "2026.04.29-004102"
  sha256 "d3b3fe1ecb5cec76de048b99f4e224d7f86c7f67bd6bc9edfa522d4236adc9d8"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Wendy Agent for macOS"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
