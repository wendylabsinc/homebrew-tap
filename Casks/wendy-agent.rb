cask "wendy-agent" do
  version "2026.07.01-101829"
  sha256 "b8e365e2dedfbf2a3327cc5256cc91dfa5fc15ebc0f2bb110676eff6f95b6d13"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
