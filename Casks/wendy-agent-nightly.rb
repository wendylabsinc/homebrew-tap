cask "wendy-agent-nightly" do
  version "2026.06.27-181514"
  sha256 "86ab9d0740828c024bc3ceb89ef3a482d600ef6dec0ba044c0094a4906209eff"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
