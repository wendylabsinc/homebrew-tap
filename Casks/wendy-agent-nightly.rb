cask "wendy-agent-nightly" do
  version "2026.07.07-073026"
  sha256 "6d92999b5e6246d2d5edaf4011934f5ee4070a41d928fc42dec85710eb7aa64f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
