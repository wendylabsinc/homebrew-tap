cask "wendy-agent-nightly" do
  version "2026.04.29-210337"
  sha256 "8708f69847880c46914876989349da69c4f282cdd3036e5e7c06328b998d86b5"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Wendy Agent for macOS (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
