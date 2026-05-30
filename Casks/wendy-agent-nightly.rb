cask "wendy-agent-nightly" do
  version "2026.05.30-035657"
  sha256 "8bd83e1afb8ce0e4f208e0dbc7be73b827939808191aefea0ba745628621267f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
