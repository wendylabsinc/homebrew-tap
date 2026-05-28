cask "wendy-agent-nightly" do
  version "2026.05.28-061552"
  sha256 "c0bc37d8d680a09165e8f1a704882e273baf8981e1973d26bfff8d5376332b3e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
