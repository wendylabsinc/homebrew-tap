cask "wendy-agent-nightly" do
  version "2026.05.31-191107"
  sha256 "5bfb56c81e4ea69d6848504e301d4caa901861dfa1f512e88013e80742092563"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
