cask "wendy-agent-nightly" do
  version "2026.06.25-125311"
  sha256 "72eb5374d75bbaf7817e8c3533aaf6fb4e99bf98c9804b2ad3ec45e8524fd3bb"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
