cask "wendy-agent-nightly" do
  version "2026.11.06-130539"
  sha256 "bc58a578689848a337d7fb5b2d119c12f61affa2348d5db2a387eec561083d51"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
