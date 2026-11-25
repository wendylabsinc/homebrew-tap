cask "wendy-agent-nightly" do
  version "2026.11.25-123520"
  sha256 "0910e351aca3b36215bb8b5712e871c276fcd33f860f04f7a80a2da91230346e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
