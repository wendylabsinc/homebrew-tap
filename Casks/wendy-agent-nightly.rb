cask "wendy-agent-nightly" do
  version "2026.05.30-025900"
  sha256 "9d7820d12bf3f0acefca44c3b7e89da06ab1daa619d8c1c1d85582d0de1d4410"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
