cask "wendy-agent-nightly" do
  version "2026.06.26-110526"
  sha256 "3436b1e4788cd3df213d2545545da357c9ce1071ee15e40136187bb48edaba3a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
