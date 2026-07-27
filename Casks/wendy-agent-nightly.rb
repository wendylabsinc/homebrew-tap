cask "wendy-agent-nightly" do
  version "2026.07.27-081952"
  sha256 "6077dd52bd841ef5e44fc8b34b14c1bc4b4b5464eb99726a249734a05aae0cf1"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
