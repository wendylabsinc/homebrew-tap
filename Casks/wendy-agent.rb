cask "wendy-agent" do
  version "2026.11.12-135023"
  sha256 "a1e179d3fe5f548537db6b5a8f8dde0f3cd5502f730ea6cbd1b43393471a826e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
