cask "wendy-agent-nightly" do
  version "2026.10.21-184756"
  sha256 "fe801657a80efcdd8e796c78672bf062ac346bd92454105ac38db79b6f8777e0"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
