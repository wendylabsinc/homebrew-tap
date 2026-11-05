cask "wendy-agent-nightly" do
  version "2026.11.05-161756"
  sha256 "4d273ef387d4af92c57cc12cc691f346c62ae8b6b1d44aa507cc0e144e739b8e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
