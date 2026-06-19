cask "wendy-agent-nightly" do
  version "2026.06.19-061228"
  sha256 "59345be3ebdb376a5df00eb61deef0e269a928ebe3fcdf31b40760fbfc05aa48"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
