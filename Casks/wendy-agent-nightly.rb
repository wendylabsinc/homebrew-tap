cask "wendy-agent-nightly" do
  version "2026.11.04-165715"
  sha256 "abfa7dbe296f5a4acb6be4cb070fd5b6e11600fe56cec1dd42019cede642d9fa"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
