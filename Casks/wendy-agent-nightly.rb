cask "wendy-agent-nightly" do
  version "2026.11.09-083225"
  sha256 "0d6d6a0cd5cfe7910ff738e8a157cc51da5efd1d7fc1a1cdfa806f969a31c703"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
