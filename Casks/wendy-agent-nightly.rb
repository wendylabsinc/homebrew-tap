cask "wendy-agent-nightly" do
  version "2026.07.01-223311"
  sha256 "cdb2e460edd8a6c5467ec94dc64507cbaef2be50ea724a072050c7969bfe4692"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
