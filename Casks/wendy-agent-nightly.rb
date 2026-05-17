cask "wendy-agent-nightly" do
  version "2026.05.17-190009"
  sha256 "0ec46f7e61c5db7630364230088a79699a011c336b04e94b28172d134ea6b5e4"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
