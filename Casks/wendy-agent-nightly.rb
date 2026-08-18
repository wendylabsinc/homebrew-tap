cask "wendy-agent-nightly" do
  version "2026.08.18-114954"
  sha256 "b35932e93588f42e009ae9cd24a36e62015ab1742426c1d740a8927b4d489511"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
