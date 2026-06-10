cask "wendy-agent-nightly" do
  version "2026.06.10-112219"
  sha256 "92cb1416ac93d73028ff14e92599312041b5d28eb616e37862c4a86ae3aaa991"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
