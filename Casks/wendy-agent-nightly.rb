cask "wendy-agent-nightly" do
  version "2026.11.02-195448"
  sha256 "3bd3be321478755ff2cc74fda2bfd85cbd87f17fb6289e56f99ff69b91ccc154"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
