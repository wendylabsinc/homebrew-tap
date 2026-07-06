cask "wendy-agent-nightly" do
  version "2026.07.06-143433"
  sha256 "b98b9b073fd77a309731bbeaafa78b4b156aea56ef831a58877a6ee68b115e1e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
