cask "wendy-agent-nightly" do
  version "2026.11.10-222230"
  sha256 "b275d6cb165383cc63592fc31d46ad5ecffc6a609c3f7c1b21f9a99608b3bb3a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
