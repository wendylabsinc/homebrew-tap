cask "wendy-agent-nightly" do
  version "2026.10.27-210035"
  sha256 "a83cad328c0010659e7e24507f52538def7f8d4f30efd4101373da0f467e7331"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
