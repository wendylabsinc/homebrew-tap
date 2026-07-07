cask "wendy-agent-nightly" do
  version "2026.07.07-115136"
  sha256 "658deca42a7e1d8bd30c27754f5880d0e4c423320013986128e6c14289f51a13"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
