cask "wendy-agent-nightly" do
  version "2026.05.18-095503"
  sha256 "e4790e1c5b1bb16fb4624ef6ce2bb5c77c3307fb5537d0bf440173793255010c"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
