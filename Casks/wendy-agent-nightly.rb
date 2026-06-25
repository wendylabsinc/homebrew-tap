cask "wendy-agent-nightly" do
  version "2026.06.25-201650"
  sha256 "2aa392bc6c1f6138f1848d9b6ca9951c36e61765300a09730c47e95768c19ec4"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
