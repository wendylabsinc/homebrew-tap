cask "wendy-agent-nightly" do
  version "2026.05.03-195540"
  sha256 "5d029a45373f61c65dfdcadb67b1b329936db8323d22b2fd79127da2964fafcd"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
