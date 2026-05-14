cask "wendy-agent-nightly" do
  version "2026.05.14-170103"
  sha256 "bc7135ca24f809a32f1cf84ea834210a5b0a2ce52ad80e0826afff5ef7e312f3"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
