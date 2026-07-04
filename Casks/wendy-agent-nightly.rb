cask "wendy-agent-nightly" do
  version "2026.07.04-053754"
  sha256 "0371969b69d8edfdadd09340ab1d656281cc87535c7b93276d573e43e3f4b626"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
