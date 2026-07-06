cask "wendy-agent-nightly" do
  version "2026.07.06-175453"
  sha256 "b41ffc9b86300a3867d0ae1fc0adf7be9a7b5f928a8b69dd4c020c13bf6d6c22"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
