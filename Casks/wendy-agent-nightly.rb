cask "wendy-agent-nightly" do
  version "2026.06.16-213753"
  sha256 "0dc714df5c54f553fef3179356578f8a2b65ca91217232e06502265a3bd83036"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
