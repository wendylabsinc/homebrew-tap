cask "wendy-agent-nightly" do
  version "2026.07.02-113642"
  sha256 "f3efcb35b273277f50151e626d28fc4d6f2a3b51eee8c7fdcc63b67fd054639d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
