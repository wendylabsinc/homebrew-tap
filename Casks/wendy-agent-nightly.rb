cask "wendy-agent-nightly" do
  version "2026.07.03-185128"
  sha256 "f562933052dee8ab172481773b0b65e8cf5eca24ac3cad42ee35ce4310a14abf"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
