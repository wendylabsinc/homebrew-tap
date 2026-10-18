cask "wendy-agent-nightly" do
  version "2026.10.18-145343"
  sha256 "92657748a98c6126c14f777268bb566432a1e7a463ba2f4503710401b567a08b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
