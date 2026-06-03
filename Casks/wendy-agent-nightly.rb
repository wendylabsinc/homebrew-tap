cask "wendy-agent-nightly" do
  version "2026.06.03-175757"
  sha256 "273c7a42b1c75523a992742cfa214fc9f42cfa1677e48fe864555b98dfdf3388"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
