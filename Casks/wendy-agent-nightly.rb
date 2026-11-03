cask "wendy-agent-nightly" do
  version "2026.11.03-074612"
  sha256 "af0cbfad09461cc4b214ea0df123495be3d62317d59a02a14bd9eb2641ff9162"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
