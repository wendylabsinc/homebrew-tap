cask "wendy-agent-nightly" do
  version "2026.06.03-194747"
  sha256 "e44f4c93a92c3c521532f28e3e8d71bf787013533413c13aa1c07a40fd06fb74"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
