cask "wendy-agent-nightly" do
  version "2026.06.25-150927"
  sha256 "57bfea06157742714d1d18079fbc4daba51ac924d6f775fd4795e8bac14665ee"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
