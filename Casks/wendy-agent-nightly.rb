cask "wendy-agent-nightly" do
  version "2026.06.10-141039"
  sha256 "1937d65403a08f10d4e521699dd776997a6d83ecb74014561146c919f6417fa9"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
