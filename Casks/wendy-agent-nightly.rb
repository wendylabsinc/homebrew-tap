cask "wendy-agent-nightly" do
  version "2026.11.12-081625"
  sha256 "60e6d35b983a39c36b0751569c7a754f9ce2cd1b169ad6c08c0991c93ff79662"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
