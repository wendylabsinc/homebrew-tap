cask "wendy-agent-nightly" do
  version "2026.08.07-235528"
  sha256 "5490d9588dc5ae9c915c1a125ead5dae97f5f05d047e264b03d4defeccc4ce99"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
