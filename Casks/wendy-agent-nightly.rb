cask "wendy-agent-nightly" do
  version "2026.06.18-193559"
  sha256 "881d01b6ad077f7e600b0d71ff9fdd642b9167cca567094c01536a5d39918195"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
