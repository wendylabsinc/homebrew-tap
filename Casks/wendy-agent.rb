cask "wendy-agent" do
  version "2026.07.27-003050"
  sha256 "806221e83266614b36c455b30d57500708f9cdc7a74cb3b1b1c81febfbe9a74b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
