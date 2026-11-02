cask "wendy-agent-nightly" do
  version "2026.11.02-163632"
  sha256 "800e0386a13014271252cc0d6c7ad9d669d35116f0d0ad4677d99feb41f3c645"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
