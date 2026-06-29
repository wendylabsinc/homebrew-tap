cask "wendy-agent-nightly" do
  version "2026.06.29-143514"
  sha256 "40b86e0aaa8e668bbccfa7f98286d0f0b69f5f360db94890b4f2fae3bf56763e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
