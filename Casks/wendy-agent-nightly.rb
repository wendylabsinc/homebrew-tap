cask "wendy-agent-nightly" do
  version "2026.08.11-002117"
  sha256 "d1cf7a8d5721fe6d723291d3337ee210881efe88bf0e4b3e806010ba959357d1"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
