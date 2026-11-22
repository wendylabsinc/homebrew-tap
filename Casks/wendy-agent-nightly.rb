cask "wendy-agent-nightly" do
  version "2026.11.22-195031"
  sha256 "e9dda85b294584b0453990a81aaf707ea871e48147bdcf8cf7567637735e71c2"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
