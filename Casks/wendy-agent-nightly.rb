cask "wendy-agent-nightly" do
  version "2026.07.02-131746"
  sha256 "8c8d1ffebe0ad2b7617e8c7f7ea348311ae457572e3391cf3f662ea40b5bd183"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
