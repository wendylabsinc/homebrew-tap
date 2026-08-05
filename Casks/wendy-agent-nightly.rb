cask "wendy-agent-nightly" do
  version "2026.08.05-144358"
  sha256 "26de9b9e03bebcb2fe5d8d129d0034e7335645f61648e557ed2fb1cc20970b44"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
