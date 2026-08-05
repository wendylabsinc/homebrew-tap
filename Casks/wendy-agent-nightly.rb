cask "wendy-agent-nightly" do
  version "2026.08.05-040534"
  sha256 "3aae4630e7497e5db50e73d8e89ab3dd7a6f6ae1739716978b03bb0f9209a5db"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
