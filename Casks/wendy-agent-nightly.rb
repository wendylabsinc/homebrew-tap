cask "wendy-agent-nightly" do
  version "2026.06.27-134050"
  sha256 "02ac244c97c584b0af2009fc571e06cdeb97cc368b1be56b77b4315e3e22f2f8"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
