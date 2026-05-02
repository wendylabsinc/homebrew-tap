cask "wendy-agent-nightly" do
  version "2026.05.02-142249"
  sha256 "b021d64c647e31a44305a4201998b4b1455098ae5be3d3ab581186d7a741fc93"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
