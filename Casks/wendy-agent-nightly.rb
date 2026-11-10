cask "wendy-agent-nightly" do
  version "2026.11.10-134713"
  sha256 "e174a2f4a7069815f7653fb7422a5d02fe19faac79a5b3b05945c2ac042eb75f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
