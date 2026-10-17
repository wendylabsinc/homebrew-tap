cask "wendy-agent-nightly" do
  version "2026.10.17-200743"
  sha256 "0073788c179061e58bc88a5cc105ff8f167e1012cae9f9a9996fc24f5452d6e6"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
