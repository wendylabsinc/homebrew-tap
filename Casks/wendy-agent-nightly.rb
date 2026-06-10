cask "wendy-agent-nightly" do
  version "2026.06.10-192651"
  sha256 "46a9146005d41bf3bb524b01883347eb3911e4b708451a732864f8d754fca943"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
