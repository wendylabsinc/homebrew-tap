cask "wendy-agent-nightly" do
  version "2026.07.04-163852"
  sha256 "f584190cfd57138824908b2d16be2f78c45680359961700ff8b6d9960fd56ea2"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
