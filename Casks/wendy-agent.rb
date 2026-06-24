# frozen_string_literal: true

cask "wendy-agent" do
  version "2026.06.24-080311"
  sha256 "c0903a4018ce66ea9cc4f1c97d06d0109616e2801d4eb262cfb32adacdbb9816"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
