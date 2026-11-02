cask "wendy-agent-nightly" do
  version "2026.11.02-224222"
  sha256 "c549826541b12b6901fd8a7de870500d09edb18168032b7ee9d3d94b0ed1e46e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
