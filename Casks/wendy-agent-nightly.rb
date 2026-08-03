cask "wendy-agent-nightly" do
  version "2026.08.03-050133"
  sha256 "b9d3ec4e537631c70227b750e5432fa5975580413f0578bc72b89fbf233eb754"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
