cask "wendy-agent-nightly" do
  version "2026.06.29-152524"
  sha256 "ed443ce039a66997afc0e5c820f738278d0a1fd9429df340034d15f49f930f92"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
