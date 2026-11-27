cask "wendy-agent-nightly" do
  version "2026.11.27-171753"
  sha256 "a0a312bfd051627c22a395ce43c1c8282ad70a417743bc3f6d9f119bf3c09e71"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
