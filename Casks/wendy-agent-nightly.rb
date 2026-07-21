cask "wendy-agent-nightly" do
  version "2026.07.21-025137"
  sha256 "592ac7bcb1a5a420a41737c0db18f3573ce53d95d1d33eb5e5cd3993165077dc"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
