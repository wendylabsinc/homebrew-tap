cask "wendy-agent-nightly" do
  version "2026.10.14-081048"
  sha256 "f546abfa26613363d72480750cd6639b4c37133cd64a16741ddf9b5590c7d269"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
