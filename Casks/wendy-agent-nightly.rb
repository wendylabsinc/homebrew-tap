cask "wendy-agent-nightly" do
  version "2026.10.18-115727"
  sha256 "729d22ac7086d62b32698659a5074c4b894253b917763e0cbee1fffc1eb73cb6"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
