# frozen_string_literal: true

cask "wendy-agent-nightly" do
  version "2026.06.23-111829"
  sha256 "07c189d630a36c80316f439f389b7427df953c011b8d979373ebf0770bebb2fd"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
