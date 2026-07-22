cask "wendy-agent-nightly" do
  version "2026.07.22-083503"
  sha256 "0955addaadd22bd10426d59bf3e5d6ca21ef6944862e0c73faf4b7e632906b79"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
