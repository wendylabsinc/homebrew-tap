cask "wendy-agent-nightly" do
  version "2026.08.03-190116"
  sha256 "53db962b552a2c432521086f2fa353ba6860ebc4d730ff127e1026616c2c3f4b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
