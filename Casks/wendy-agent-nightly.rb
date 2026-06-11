cask "wendy-agent-nightly" do
  version "2026.06.11-073704"
  sha256 "6d88914c253c4e705b6eeb9c51d2daa7c98838a817b0096563ba47c2df9fc53e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
