cask "wendy-agent-nightly" do
  version "2026.10.07-071950"
  sha256 "ce77b33a9921af4752e586cc4f9dfc63339b29b813d0348f14bca6cf290414db"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
