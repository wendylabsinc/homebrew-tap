cask "wendy-agent-nightly" do
  version "2026.07.02-152701"
  sha256 "a3c5cde3081e5d52cfbe4d846f6fe2b7c0775621726a9effa04c14cda98f9fb8"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
