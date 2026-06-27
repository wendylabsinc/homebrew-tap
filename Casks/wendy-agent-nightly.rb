cask "wendy-agent-nightly" do
  version "2026.06.27-090906"
  sha256 "598484221c916e28ed994671936e2c019534a6304cf9381294be1a8835aa0760"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
