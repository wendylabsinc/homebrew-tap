cask "wendy-agent-nightly" do
  version "2026.05.29-213935"
  sha256 "82d6ea23351b6f26b4d2762f912996739aec633d9dc0660f308a3f32e7eb6f5a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
