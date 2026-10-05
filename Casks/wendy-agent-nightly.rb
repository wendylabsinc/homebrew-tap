cask "wendy-agent-nightly" do
  version "2026.10.05-125440"
  sha256 "fb02dea2853c617ef677fcc7bcf026904b0cb7c89cd562edff741009d48ec2bd"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
