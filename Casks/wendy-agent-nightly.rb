cask "wendy-agent-nightly" do
  version "2026.06.11-213924"
  sha256 "4517e117f97230c430a246576e9c586fd94d6b6aed6b6a54d9ba818c52c48082"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
