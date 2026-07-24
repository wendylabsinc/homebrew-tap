cask "wendy-agent-nightly" do
  version "2026.07.24-064853"
  sha256 "a7928c972408a77ad4fbc4e190754608c25a263f82eed716df2771c95903f39e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
