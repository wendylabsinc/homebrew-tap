cask "wendy-agent-nightly" do
  version "2026.06.05-160853"
  sha256 "47ba16c2dda830775c74f16b1f92ce79b2b3e33f884a7e0f0e15c6e291a685c3"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
