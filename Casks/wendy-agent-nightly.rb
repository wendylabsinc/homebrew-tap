cask "wendy-agent-nightly" do
  version "2026.10.05-105625"
  sha256 "c5d96116aaf4f054d569f4be10d40bb1df1d86e3d35d695ae4e00cf317053369"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
