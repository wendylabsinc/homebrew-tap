cask "wendy-agent-nightly" do
  version "2026.10.16-073954"
  sha256 "8a730910f1243f632a90b4d18d7d8df872a09561e03954f3f6dfe08fa53f8b00"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
