cask "wendy-agent-nightly" do
  version "2026.10.26-220711"
  sha256 "0f350c2886beb18e20e0bc6cd2e5f329b1bce36d7fbd83a68e3bf960996ecbec"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
