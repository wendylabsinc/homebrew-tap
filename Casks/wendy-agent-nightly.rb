cask "wendy-agent-nightly" do
  version "2026.06.06-180932"
  sha256 "cedfc9cbf60da6b8726568f5fc9db641cda9fdb3eb6bf0cea0569df656742ca8"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
