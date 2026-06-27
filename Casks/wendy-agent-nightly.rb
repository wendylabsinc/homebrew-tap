cask "wendy-agent-nightly" do
  version "2026.06.27-171712"
  sha256 "4e574777ebef9cffabf68adf911bb43e8cd558505f52228d81a544462214b822"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
