cask "wendy-agent-nightly" do
  version "2026.07.06-184918"
  sha256 "0f974773c5de615d83b5b3ccb50f2f11899f7cae99e3f156e8b5332fd15ba4b2"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
