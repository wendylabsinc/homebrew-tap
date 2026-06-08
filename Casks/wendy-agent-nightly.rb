cask "wendy-agent-nightly" do
  version "2026.06.08-183544"
  sha256 "7a37e1c2b0fe37695e6b24c7763adbf6545641942581cf31032fe19fd3d682a1"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
