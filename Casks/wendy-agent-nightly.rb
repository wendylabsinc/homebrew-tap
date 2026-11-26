cask "wendy-agent-nightly" do
  version "2026.11.26-123334"
  sha256 "9f866b9a3605119d648625edd119b5ed722e44ac2bb4120fb9b5ea64cb6cb7cd"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
