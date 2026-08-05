cask "wendy-agent-nightly" do
  version "2026.08.05-220434"
  sha256 "20e92ad3da5ce47f2e9f200a358e445b25410fff9bcb8bbd5292b7743d0458b3"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
