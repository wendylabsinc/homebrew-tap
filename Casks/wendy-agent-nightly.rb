cask "wendy-agent-nightly" do
  version "2026.06.09-114217"
  sha256 "8fd86d12673d0b69a5c79f5ab84eb3f181b14f8a1a4e51f9c62cc40cd47ca66a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
