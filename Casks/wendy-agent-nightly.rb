cask "wendy-agent-nightly" do
  version "2026.07.03-133530"
  sha256 "e1c508a422b8cff4f222c30bdc305e98d88aaf43ba092731b6f446abdc3a6958"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
