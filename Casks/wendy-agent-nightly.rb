cask "wendy-agent-nightly" do
  version "2026.10.06-124344"
  sha256 "c89cb1d216318eb09c9d0746b3c9d344b25f095064efb1389316d27f4b65d016"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
