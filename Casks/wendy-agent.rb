cask "wendy-agent" do
  version "2026.07.15-045528"
  sha256 "635111b31d2cbcc056085735bf450fe70ddafde63ea3fc93daa833888fb7f05a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
