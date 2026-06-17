cask "wendy-agent-nightly" do
  version "2026.06.17-145209"
  sha256 "5af2b17a4e168d5c93674b8d9cdce5babc39fe16e9cedb731270e3362e70fad4"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
