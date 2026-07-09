cask "wendy-agent-nightly" do
  version "2026.07.09-130756"
  sha256 "0f281ba23bdf2d154916c4edef527f6faaa5f0ee3d2b3dcfda1386c1c84783e8"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
