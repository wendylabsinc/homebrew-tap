cask "wendy-agent" do
  version "2026.05.31-060504"
  sha256 "adbf2871ad2883a30c434f97b6e3f93dcad4d09298df78cb6addd7233cd2c092"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
