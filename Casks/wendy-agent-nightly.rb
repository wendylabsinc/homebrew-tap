cask "wendy-agent-nightly" do
  version "2026.07.06-085734"
  sha256 "1d46ebe75e6673e0d0a108c48532ed5658decb31de4a39edc118df31b3d3c206"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
