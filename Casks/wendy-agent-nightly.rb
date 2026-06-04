cask "wendy-agent-nightly" do
  version "2026.06.04-073747"
  sha256 "6112c08caec82259de4784d0546dc5a4b6fecc7a1572c357bb7387161216b5cb"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
