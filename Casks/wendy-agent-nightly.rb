cask "wendy-agent-nightly" do
  version "2026.05.19-111156"
  sha256 "6e1085037a0d9ff22db03ec8911857fc9914e49e6485a151da717ec74ac8b5c9"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
