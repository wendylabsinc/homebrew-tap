cask "wendy-agent-nightly" do
  version "2026.11.03-152257"
  sha256 "8564e7430e2d44672075e2a03de945fc27e5538b826ca4d5fc5a9e49130215d0"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
