cask "wendy-agent-nightly" do
  version "2026.06.03-172303"
  sha256 "9e54038477aa2a402be24fd1693a2155ddaa0bf1e1ae15393fa68852d0dd46cc"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
