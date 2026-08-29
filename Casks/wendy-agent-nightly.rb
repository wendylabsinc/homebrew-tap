cask "wendy-agent-nightly" do
  version "2026.08.29-162919"
  sha256 "e379ad174d57c84ca3291ec24d79d7188dd69eed987f9151da303355c7292fd0"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
