cask "wendy-agent-nightly" do
  version "2026.07.07-174442"
  sha256 "a6c2234b7552a13248871d90291b63f7a75e27b5c6e434f052ac91d081fe4d61"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
