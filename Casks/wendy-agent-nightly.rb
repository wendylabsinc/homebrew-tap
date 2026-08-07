cask "wendy-agent-nightly" do
  version "2026.08.07-015704"
  sha256 "7d02feca0381c5e46de31f9debeaf5221a45eae8628d76e28437d219c29e99ad"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
