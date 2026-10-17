cask "wendy-agent-nightly" do
  version "2026.10.17-205232"
  sha256 "cd63a9fc5e0aa5f0f1c224f32a170b5990e7863b00932a5a3922a3f25d023e2a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
