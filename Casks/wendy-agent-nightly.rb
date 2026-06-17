cask "wendy-agent-nightly" do
  version "2026.06.17-140825"
  sha256 "ad5fdf6ee67830da4405651ba6311be26b44953c0c66faa20394f9acf21f13b9"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
