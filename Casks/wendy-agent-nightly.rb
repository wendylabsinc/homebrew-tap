cask "wendy-agent-nightly" do
  version "2026.05.02-014912"
  sha256 "4771db5473dbda5a68e890426233d03e6b19d2e475f9f84f4562c4a4cdea10f3"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
