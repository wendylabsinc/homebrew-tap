cask "wendy-agent-nightly" do
  version "2026.04.25-221645"
  sha256 "aa6449c330e623c202646307b31fce2c0cd89c0b8b684c1b7ca6c455dc9b4da8"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Wendy Agent for macOS (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
