cask "wendy-agent-nightly" do
  version "2026.06.22-140229"
  sha256 "e0b7c50d011775089c76f21c7c35dca40a1e198f0231b20704d7516aff340a2d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
