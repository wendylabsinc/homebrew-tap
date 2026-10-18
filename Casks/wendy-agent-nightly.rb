cask "wendy-agent-nightly" do
  version "2026.10.18-221733"
  sha256 "80ddb7f23623db15942aa4d1c6331bbbcc167e59bbb713d87e05bb298e2cc821"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
