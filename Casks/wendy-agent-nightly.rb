cask "wendy-agent-nightly" do
  version "2026.06.27-182952"
  sha256 "e47fa5153764d3e941251fbe350252c2d9f312055f27d2ddeb990cb6051e4c39"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
