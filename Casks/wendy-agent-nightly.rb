cask "wendy-agent-nightly" do
  version "2026.06.25-122346"
  sha256 "ac7d72163b3b00a6f317b787a0b4c7437ba5bef139a0592abc20edfe7dd5ad66"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
