cask "wendy-agent-nightly" do
  version "2026.11.22-221500"
  sha256 "e4bd33ea7dbb6e82b1e621ead3717994b2ac31fc82054b27818060edb75bc108"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
