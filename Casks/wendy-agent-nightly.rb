cask "wendy-agent-nightly" do
  version "2026.07.29-012411"
  sha256 "fa150770b2ac93fe384f61b227658430e10f9fd2575a286d929206b59f879f4b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
