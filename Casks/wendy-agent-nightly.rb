cask "wendy-agent-nightly" do
  version "2026.07.05-212536"
  sha256 "16dd8161bf827106f2b462698d4fa356bee33800f97357306dd5d6b7da8dc960"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
