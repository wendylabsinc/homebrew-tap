cask "wendy-agent-nightly" do
  version "2026.09.21-233917"
  sha256 "50c2e0897d0c6c75495f66ba95f9f027bb95d1eab3aac97123bbc5d2ce3bc64d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
