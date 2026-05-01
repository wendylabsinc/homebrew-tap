cask "wendy-agent-nightly" do
  version "2026.05.01-114334"
  sha256 "fa25c5ccabe1310603fd2e1a81a663e77e47a49f996aaeaa2a2bd7776563166a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
