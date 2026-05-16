cask "wendy-agent-nightly" do
  version "2026.05.16-183003"
  sha256 "0426afdaf88c0ecbad7da876d513a1cabe6238eb6a89a54cbbb19c61026aaeba"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
