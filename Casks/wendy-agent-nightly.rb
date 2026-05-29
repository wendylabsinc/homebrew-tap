cask "wendy-agent-nightly" do
  version "2026.05.29-132910"
  sha256 "4964aad80e1a42f64d3f19f10dfaa83b1008b059039776f12ff5a02d96ef945f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
