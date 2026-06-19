cask "wendy-agent-nightly" do
  version "2026.06.19-113242"
  sha256 "ddb9b1c1c9b61bde2264778e03c2773157e03aafd9d965a7681d7506400dce41"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
