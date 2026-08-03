cask "wendy-agent-nightly" do
  version "2026.08.03-154839"
  sha256 "7979c79c352ece4941c29c7a987ea5b0dc902351e80cbec1e8f8762a3430df3a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
