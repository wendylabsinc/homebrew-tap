cask "wendy-agent-nightly" do
  version "2026.05.17-000308"
  sha256 "f6e5f7e19f4ef2a81dbb21a48e39d48acd2040ba14f11a09655834e1aed6cdbd"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
