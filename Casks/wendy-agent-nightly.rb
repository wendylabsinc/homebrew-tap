cask "wendy-agent-nightly" do
  version "2026.06.22-123648"
  sha256 "36b16eb48d11f09d5c78330d075d48b020b4a38de15a922da7fc137c4a6336a7"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
