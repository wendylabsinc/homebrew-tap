cask "wendy-agent-nightly" do
  version "2026.11.02-205119"
  sha256 "d8d4587bd2867dad7fef723cb2e4e8fa15883e12f40727dceabb26ac6c3de7bf"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
