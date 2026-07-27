cask "wendy-agent-nightly" do
  version "2026.07.27-050002"
  sha256 "e28046acae9908788ceb9a97380975e274db12554612cea928f448cac03c310b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
