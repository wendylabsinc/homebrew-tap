cask "wendy-agent-nightly" do
  version "2026.06.19-183302"
  sha256 "32d0052376417ea241bce4e1492ce13a65ae2f1bf18945c9b0495deaa2fea49b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
