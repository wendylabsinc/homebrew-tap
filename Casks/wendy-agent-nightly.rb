cask "wendy-agent-nightly" do
  version "2026.07.22-183213"
  sha256 "9aeb642f0483338e3f153b0a7440b1aefdd3f43c3e373b86ca048ddfe10b6baf"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
