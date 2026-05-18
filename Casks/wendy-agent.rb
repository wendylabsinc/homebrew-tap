cask "wendy-agent" do
  version "2026.05.13-154939"
  sha256 "cd92efd5d9cdc0676d39009214d50ebe0dc762aafedbf7114a13ad599d852481"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
