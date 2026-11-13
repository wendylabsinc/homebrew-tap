cask "wendy-agent-nightly" do
  version "2026.11.13-154113"
  sha256 "9d5f82655b8256b193daf87ef9e814c412c13d85b35479c330136a73f3858289"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
