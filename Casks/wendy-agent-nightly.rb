cask "wendy-agent-nightly" do
  version "2026.07.07-091734"
  sha256 "7edae26111dd09efe594a16176d448e1c3bcbdc582ae09dc6debd83af0ad4d54"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
