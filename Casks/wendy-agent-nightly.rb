cask "wendy-agent-nightly" do
  version "2026.06.10-083808"
  sha256 "6c56d0d8ab6ce26374cb7321aa42b4c41ae73e1f0a421dab0f1b51a245eceb7f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
