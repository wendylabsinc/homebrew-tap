cask "wendy-agent-nightly" do
  version "2026.10.22-091205"
  sha256 "5e697851762e4f5959bfd4495f159751f0a6917bbd005383d7cea5de84381ac8"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
