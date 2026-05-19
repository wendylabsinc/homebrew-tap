cask "wendy-agent-nightly" do
  version "2026.05.19-090119"
  sha256 "c6a0e035225cbabb0f2c4869c642a8e1a58c5c8e3a77749d42a2942b28ab2706"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
