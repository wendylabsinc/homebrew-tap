cask "wendy-agent-nightly" do
  version "2026.05.22-201747"
  sha256 "4e746694be0d6f13f7f854ca38f8567b5ebf06f3399384b882eae91619f1c49a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
