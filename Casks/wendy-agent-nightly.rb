cask "wendy-agent-nightly" do
  version "2026.06.17-142611"
  sha256 "225379b5b5e32cbc49322661b52d85660745b286622fa04b6c6fe6f6e2eccb4f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
