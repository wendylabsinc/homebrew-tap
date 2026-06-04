cask "wendy-agent-nightly" do
  version "2026.06.04-214249"
  sha256 "d01ad5b1f10744a48f2f38000e5e6399728267705d7053d20c3bf0740ae19e00"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
