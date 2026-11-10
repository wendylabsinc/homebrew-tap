cask "wendy-agent-nightly" do
  version "2026.11.10-160647"
  sha256 "290f0f0acff7a113ad8be07dd0f5e692f9672dbef84dfae8ea2f07a09a313e22"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
