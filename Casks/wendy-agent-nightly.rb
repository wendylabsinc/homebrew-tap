cask "wendy-agent-nightly" do
  version "2026.08.22-053704"
  sha256 "39cc92312c7abc653c3df354206a571acbd0e7615ab85603252be1982adb84f3"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
