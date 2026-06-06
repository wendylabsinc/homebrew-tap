cask "wendy-agent-nightly" do
  version "2026.06.06-165924"
  sha256 "d43a48d9de95f1b7c43abd944a491b117ad43d80c2f0adaffcc063da16eb2a80"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
