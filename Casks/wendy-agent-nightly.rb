cask "wendy-agent-nightly" do
  version "2026.07.04-173245"
  sha256 "be9d5844e82d6b74c7ce00c9895ffe4b0ea3e3e587a6e151e34f4c872159a1a7"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
