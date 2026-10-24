cask "wendy-agent" do
  version "2026.10.24-200705"
  sha256 "0ed0cd1db8963efeb8b9c8025f9821cd293cfb8a32746766897d15f71b124b13"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
