cask "wendy-agent-nightly" do
  version "2026.08.11-012845"
  sha256 "f6c9e85e94faa575f8a0a1ab6cca7f2d3f5ef87482c001bf8a0aac0c70b198b7"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
