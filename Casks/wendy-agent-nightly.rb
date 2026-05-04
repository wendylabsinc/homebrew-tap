cask "wendy-agent-nightly" do
  version "2026.05.04-080718"
  sha256 "d37618dcf68d238b788f7693733641907718fa32d2ece371a60ff01ee14cbe5a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
