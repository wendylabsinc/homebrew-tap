cask "wendy-agent-nightly" do
  version "2026.10.29-201420"
  sha256 "e2bd90c77c24ba483f965adc7222020ac432025cda34275ecdf8d11e30f6251b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
