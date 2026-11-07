cask "wendy-agent-nightly" do
  version "2026.11.07-165019"
  sha256 "6fe0566a48a9e3b5dd2b1cce2302a26f6a7cfe540ed84c65e54eda690e101b4c"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
