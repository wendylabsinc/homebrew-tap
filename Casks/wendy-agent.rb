cask "wendy-agent" do
  version "2026.10.01-013419"
  sha256 "dac209259687ecd828b5e5a4cab81aa54238ed3fb55288deffbecc240b62f819"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
