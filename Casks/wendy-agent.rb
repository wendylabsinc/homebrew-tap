cask "wendy-agent" do
  version "2026.09.28-142251"
  sha256 "7d16cc9aa168c750939171dbe24fba9242048da128f24acb68f6067d42bb5fd5"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
