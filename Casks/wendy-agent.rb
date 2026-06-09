cask "wendy-agent" do
  version "2026.06.09-132309"
  sha256 "d02d6c2d501cad2656257f5ecabcca487c6a07eabd558d20b50cc19e41334e2f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
