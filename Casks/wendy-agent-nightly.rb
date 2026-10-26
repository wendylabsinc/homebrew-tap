cask "wendy-agent-nightly" do
  version "2026.10.26-150335"
  sha256 "bb54301985dd17eb51b11eb0a73de4756941eba68788f1cada03c7a2b1bae7db"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
