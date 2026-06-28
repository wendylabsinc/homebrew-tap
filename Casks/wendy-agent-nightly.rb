cask "wendy-agent-nightly" do
  version "2026.06.28-191102"
  sha256 "8125a6f7758bad83f80536ab94edad4847390383801a18ff3bb83295b7c71ef9"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
