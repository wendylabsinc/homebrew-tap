cask "wendy-agent-nightly" do
  version "2026.10.16-134114"
  sha256 "76492f1f09cdf541a1f5ec425757dec38a73ae11370d0e3d9f0963dd81857a62"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
