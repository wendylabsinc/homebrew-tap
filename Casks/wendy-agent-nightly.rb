cask "wendy-agent-nightly" do
  version "2026.05.11-150334"
  sha256 "3457f112b4c3e4eaea0985d94a29d5ab3b828f38a858750d10a5637db9c01a31"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
