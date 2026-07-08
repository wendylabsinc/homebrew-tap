cask "wendy-agent-nightly" do
  version "2026.07.08-145314"
  sha256 "595911b0e96af31115e92c3aeca58533448b1df35d07b83b19dec7cd46076534"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
