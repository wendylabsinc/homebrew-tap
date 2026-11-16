cask "wendy-agent-nightly" do
  version "2026.11.16-061157"
  sha256 "aeadec703d19818a7fe3fd6d92c5923af44e08cdac8a4c3ad49d8750b14e0d81"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
