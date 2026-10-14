cask "wendy-agent-nightly" do
  version "2026.10.14-093835"
  sha256 "45778a9cb821026bc212c10df05228a53e39697cdf395bc0da78d719904169ab"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
