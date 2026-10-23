cask "wendy-agent-nightly" do
  version "2026.10.23-205216"
  sha256 "bed445fed78e6c9787699083f981623ca34b02dad0f415b484baa1632ec170af"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
