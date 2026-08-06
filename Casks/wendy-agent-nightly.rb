cask "wendy-agent-nightly" do
  version "2026.08.06-025121"
  sha256 "6ddd29db0953f5870339f6edf20ef6821d5d7061cf806643c35400ec69fdcd60"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
