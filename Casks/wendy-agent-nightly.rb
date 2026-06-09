cask "wendy-agent-nightly" do
  version "2026.06.09-175520"
  sha256 "eb6a4d2924a26a40c571f972817562c35a4060129aa3261c5e1071c93b79325a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
