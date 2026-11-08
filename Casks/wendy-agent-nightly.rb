cask "wendy-agent-nightly" do
  version "2026.11.08-183227"
  sha256 "8e483ce556af9481d52aef5506eabad7bf79395fb4dab69a972f3ef6a29b6543"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
