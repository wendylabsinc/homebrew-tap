cask "wendy-agent-nightly" do
  version "2026.08.28-181359"
  sha256 "a72c8a07c2b0e62f2a2c17c470a6f7e8d6571760d297cccca29f0bf8457aab87"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
