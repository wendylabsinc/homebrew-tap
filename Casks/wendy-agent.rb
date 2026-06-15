cask "wendy-agent" do
  version "2026.06.15-231721"
  sha256 "16e00e5a5561f879ad6759aee7f1bc70e61c8945354b9fac9626a63015155e5b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
