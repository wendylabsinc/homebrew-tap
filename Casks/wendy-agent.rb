cask "wendy-agent" do
  version "2026.05.23-190411"
  sha256 "2f342d3fe5676d80b2a93eefa9e218f00b382e9d5f7a112c6bf9ecb655676a51"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
