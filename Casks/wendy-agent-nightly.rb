cask "wendy-agent-nightly" do
  version "2026.11.02-120840"
  sha256 "79342abcf4cd5c2a5c257eea7ac49890b76c7bf0b50ea62759c05d876157935f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
