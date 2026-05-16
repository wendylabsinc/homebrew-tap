cask "wendy-agent-nightly" do
  version "2026.05.16-203012"
  sha256 "c2fe069fd3bab13091615a7b2c7909fe35c65c11d014ad6dac60e69d5782c465"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
