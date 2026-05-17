cask "wendy-agent-nightly" do
  version "2026.05.17-150305"
  sha256 "632bcef8e78966aa012fdf8d435fccafae41d51c8241469cbc26583e6e017c2f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
