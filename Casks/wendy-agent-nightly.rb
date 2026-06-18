cask "wendy-agent-nightly" do
  version "2026.06.18-101840"
  sha256 "dc2cba621eee5d57bfc6a389ab9171a283174d8c97cc16a6812e3d2eaee970a9"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
