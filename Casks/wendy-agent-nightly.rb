cask "wendy-agent-nightly" do
  version "2026.09.21-123706"
  sha256 "bd4e28aff31902e30d5c303446e7d83bd3b7a6569a8a3c6ad6397a0cef13ad62"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
