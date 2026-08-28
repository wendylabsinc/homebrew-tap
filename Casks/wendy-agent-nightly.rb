cask "wendy-agent-nightly" do
  version "2026.08.28-194138"
  sha256 "f76b5ad9efe9a9812548e1b83fe99001ade8d24af359bd5e265dab2887b19479"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
