cask "wendy-agent-nightly" do
  version "2026.05.03-151137"
  sha256 "c28c320a7aca11667d782ee8cbe6dbca4a4af6ece0f24fa8ca2bd3ac9bcf855c"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
