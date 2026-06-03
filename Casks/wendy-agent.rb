cask "wendy-agent" do
  version "2026.06.03-065502"
  sha256 "065a53fdac4d326793151ea01563bb21873012c95f8c812e72c5cffbf272c979"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
