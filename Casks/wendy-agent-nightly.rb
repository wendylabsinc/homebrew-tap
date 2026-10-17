cask "wendy-agent-nightly" do
  version "2026.10.17-183612"
  sha256 "c90b0990fedbcc880d531f48450ccc75bb541a7c3cbbef7bd6dae1b9210b5f97"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
