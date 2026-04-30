cask "wendy-agent-nightly" do
  version "2026.04.30-152136"
  sha256 "b297849289d941b953700ca4e2c596bdc2bcac217e4cc3c16b83f1e1408fed65"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
