cask "wendy-agent-nightly" do
  version "2026.11.26-154750"
  sha256 "0c0b569c7513e786b813bf7f98bac422606b1cfb6c78ea5ecd6ecd8a177640d7"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
