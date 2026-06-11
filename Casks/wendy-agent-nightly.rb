cask "wendy-agent-nightly" do
  version "2026.06.11-070111"
  sha256 "e85b04da79f77b91f8cc6a6fbd76671ac0d0abd87760803fc756d6f96700f48e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
