cask "wendy-agent-nightly" do
  version "2026.11.14-193040"
  sha256 "05d4340693304947b91bf9cee5c80cb6e06ff12962b1386dad3eec95bcd967db"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
