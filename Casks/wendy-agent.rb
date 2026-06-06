cask "wendy-agent" do
  version "2026.06.06-232448"
  sha256 "f67e6a57d5487b538ff6ff33e4eb05fa7a0df01f92ef3d72a7ed81d216347e86"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
