cask "wendy-agent-nightly" do
  version "2026.10.27-180912"
  sha256 "f94654924e98716633b17596d94798903c7041c3fa8239738a9a0241a8efbeaa"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
