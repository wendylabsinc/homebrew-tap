cask "wendy-agent-nightly" do
  version "2026.06.09-102117"
  sha256 "7d9e549449fb884ee5177f895b3236efd8e21caec7d10bb7fd808968ebc2d3b9"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
