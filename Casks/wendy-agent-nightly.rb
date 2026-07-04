cask "wendy-agent-nightly" do
  version "2026.07.04-175124"
  sha256 "2aa69c17ce1411be57ff989935f36886be7b17795d856bcd2accafac695bc33d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
