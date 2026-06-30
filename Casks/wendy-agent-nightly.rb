cask "wendy-agent-nightly" do
  version "2026.06.30-161156"
  sha256 "5fe744c752eba08f49dcaaab55abc0aeab8a5865ae8e0b675258d54f91597273"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
