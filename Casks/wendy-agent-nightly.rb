cask "wendy-agent-nightly" do
  version "2026.11.06-002931"
  sha256 "ab0403575032bfce47862460d0fd5b49d204eb4a714357c4bcfdd2125c161f75"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
