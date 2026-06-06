cask "wendy-agent-nightly" do
  version "2026.06.06-192058"
  sha256 "90fc64ce8aafce8f007040abc041ff73771cb75151b7cc34e7335534e326fe0f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
