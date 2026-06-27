cask "wendy-agent-nightly" do
  version "2026.06.27-233704"
  sha256 "69a0aba59e9b5b0e95d96ee7a7f5f556c2ed12f9f940c37cd17adc579ed9bf6b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
