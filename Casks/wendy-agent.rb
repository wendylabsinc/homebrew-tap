cask "wendy-agent" do
  version "2026.11.04-081952"
  sha256 "cbfab4a3f992128d4ca1ab1b1af1ffc5fe7ac1595b062e63a07b80e73446f369"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
