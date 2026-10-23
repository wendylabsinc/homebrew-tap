cask "wendy-agent-nightly" do
  version "2026.10.23-174709"
  sha256 "e53a321534d1b833058cb57331878448a2c3d028b948b7e1cd42d5c6a3fc9fc0"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
