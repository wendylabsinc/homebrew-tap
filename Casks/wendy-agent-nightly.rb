cask "wendy-agent-nightly" do
  version "2026.09.19-173329"
  sha256 "4ee49a18bba0d294e54ad0510ec1dca8b924249f3806c23d841a5b3db62a99ff"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
