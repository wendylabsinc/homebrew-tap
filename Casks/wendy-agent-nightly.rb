cask "wendy-agent-nightly" do
  version "2026.05.03-143941"
  sha256 "b682f70fff1a62d8dc04e30896523605329102242a814dfa7d98f72b36ca99c5"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
