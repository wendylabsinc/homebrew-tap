cask "wendy-agent-nightly" do
  version "2026.10.21-092651"
  sha256 "8d6cdedb45f566760163f733cfccf84c04614e076e531913e27078ba6d8013c7"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
