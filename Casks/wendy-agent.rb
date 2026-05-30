cask "wendy-agent" do
  version "2026.05.30-161141"
  sha256 "1bac78f72aee1014ec071f2eb636d1f0d6ea0823d50b1bf982959f2ab2f64af2"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
