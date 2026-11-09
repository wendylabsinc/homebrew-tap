cask "wendy-agent-nightly" do
  version "2026.11.09-204738"
  sha256 "3e6992d41ebca6fcb84302a23ff4e7670085e51e1916df2e9b9da4f221155292"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
