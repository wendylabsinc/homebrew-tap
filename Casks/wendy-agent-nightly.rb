cask "wendy-agent-nightly" do
  version "2026.11.11-074823"
  sha256 "f40d9ce126a2dd8aed3fad48b9ed0f4601d803c3d3de61c1463d052a8c09c260"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
