cask "wendy-agent-nightly" do
  version "2026.10.28-181236"
  sha256 "e9ed6a8306d6a291d357944593abf17c97e01d78502f5f88c041563afbb81432"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
