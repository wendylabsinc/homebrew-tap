cask "wendy-agent-nightly" do
  version "2026.11.02-091526"
  sha256 "3f88803c34119b396c77a04f9a2079c1df05431f7e771ad0eed593f39f328bfc"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
