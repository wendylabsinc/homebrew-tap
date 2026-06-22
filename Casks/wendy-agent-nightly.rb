cask "wendy-agent-nightly" do
  version "2026.06.22-160225"
  sha256 "43acd5516221176c1a00d97fa0ec68cf03e2d34dacd83d3a071cdfb7ecd034b9"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
