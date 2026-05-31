cask "wendy-agent-nightly" do
  version "2026.05.31-202736"
  sha256 "0328bca94c45a68881dd96d1e86214510061701438c7a5c92bf7553097a08e79"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
