cask "wendy-agent-nightly" do
  version "2026.08.07-222520"
  sha256 "9f6177d0ab7a9e07b61364d17aefce71f629d94d6d63255bd4abdc5a498d8d40"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
