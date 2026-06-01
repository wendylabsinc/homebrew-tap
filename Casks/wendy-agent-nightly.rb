cask "wendy-agent-nightly" do
  version "2026.06.01-034659"
  sha256 "11740eff51fac7dc22549cc21efc969098a0a9edd2ef8bffb3e3c5ce2a34ae5a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
