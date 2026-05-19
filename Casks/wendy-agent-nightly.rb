cask "wendy-agent-nightly" do
  version "2026.05.18-213432"
  sha256 "4d6cb97d883ff83560bab2a85aa39bb084372085ea753ab67ed8ca530f01a38d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
