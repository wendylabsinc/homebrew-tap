cask "wendy-agent-nightly" do
  version "2026.05.04-162049"
  sha256 "c2f07aa7b1f96c5051217236934298678ba53a2b414a310857e69ebe57f32329"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
