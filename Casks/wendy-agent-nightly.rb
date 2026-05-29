cask "wendy-agent-nightly" do
  version "2026.05.29-050321"
  sha256 "4f18d373bdd916688911782e07a63fad6bc13c47e842566b4f9e24cb95f04bfc"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
