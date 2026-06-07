cask "wendy-agent-nightly" do
  version "2026.06.07-123437"
  sha256 "377176822999005db737abe998b69267eb9991a918a73591c9d94d67128b0ffe"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
