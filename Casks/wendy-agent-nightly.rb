cask "wendy-agent-nightly" do
  version "2026.10.30-070009"
  sha256 "b0374b207801b56434d155410dd97853618b827075050c7aa829c42d325ca258"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
