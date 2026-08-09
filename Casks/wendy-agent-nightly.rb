cask "wendy-agent-nightly" do
  version "2026.08.09-021238"
  sha256 "9157153af0cf40373fa319019d3484a579ddeb0cb75c04218809eaf9e0a0b5d2"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
