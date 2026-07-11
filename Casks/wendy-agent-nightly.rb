cask "wendy-agent-nightly" do
  version "2026.07.11-055428"
  sha256 "45167b42611e0810e8bd5ebf67a2948e2b574ae5b77e45375dd387b8437f95bc"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
