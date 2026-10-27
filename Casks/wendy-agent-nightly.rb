cask "wendy-agent-nightly" do
  version "2026.10.27-083339"
  sha256 "8aa3c598f56b42337be20de1cf674891b4ce2f38026557ef8440d3f4d1073dd6"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
