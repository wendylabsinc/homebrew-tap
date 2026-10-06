cask "wendy-agent-nightly" do
  version "2026.10.06-071824"
  sha256 "8d66773da0581c0057caacfef67762b5942b94a04c5382168e2d2d866478fd41"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
