cask "wendy-agent" do
  version "2026.08.10-054004"
  sha256 "4a75954eab58eb94b212c447c09d3b949dfcc8300bf8f05bb37ca43a319e3858"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
