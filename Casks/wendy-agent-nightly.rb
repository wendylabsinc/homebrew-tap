cask "wendy-agent-nightly" do
  version "2026.08.07-183405"
  sha256 "902f8dd6adb1f607cd52223b2b46408319ecb633dbba4538134e4d3fa4db64d1"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
