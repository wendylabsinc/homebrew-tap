cask "wendy-agent-nightly" do
  version "2026.10.20-195813"
  sha256 "0ac5e54e31f7c0b5279e70723ea0d3c3311815910757557654dab5a5507b0843"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
