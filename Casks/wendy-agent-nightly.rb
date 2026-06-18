cask "wendy-agent-nightly" do
  version "2026.06.18-175615"
  sha256 "b7ba6de54a86ec0a5820d01c2d28fd2f0786d261d55beec4c12e1d6d01c27141"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
