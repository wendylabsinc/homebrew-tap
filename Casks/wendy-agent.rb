cask "wendy-agent" do
  version "2026.10.05-134249"
  sha256 "c6b61cff611e22ec0b4495cf538006a15176e1219c8c2de6b179c7383a1d8a33"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
