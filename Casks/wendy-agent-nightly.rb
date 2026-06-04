cask "wendy-agent-nightly" do
  version "2026.06.04-124517"
  sha256 "6a4126af35746c33e2a87c7dcc48be68367e33d7eefcec3ceda9f6fa4bff31ab"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
