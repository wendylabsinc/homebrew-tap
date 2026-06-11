cask "wendy-agent-nightly" do
  version "2026.06.11-222624"
  sha256 "5326e8652bda8a93823fd1684686f371eb0d3865ee90fd13bad577cb8292198c"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
