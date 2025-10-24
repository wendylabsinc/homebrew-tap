cask "wendy" do
  version "2025.10.24-142919"
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"
  
  on_macos do
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.24-142919/wendy-cli-macos-arm64.tar.gz"
    sha256 "cbe1d957dccc003d84cce2e58040462379fb24cf34016ed07c107c99ad2e7bab"

    # Install the binary
    binary "wendy-cli-macos-arm64/wendy"
    artifact "wendy-cli-macos-arm64/wendy-agent_wendy.bundle",
            target: "/Library/Application Support/Wendy/wendy-agent_wendy.bundle"
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.24-142919/wendy-cli-linux-static-musl-aarch64.tar.gz"
      sha256 "a52f35021d00acc8d56c42661f14aa27023cfef5f6daeeb3ccb97e1ee1e28f18"

      # Install the binary
      binary "wendy-cli-linux-static-musl-aarch64/wendy"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.24-142919/wendy-cli-linux-static-musl-x86_64.tar.gz"
      sha256 "0b5c740257a1f803d9ad82a4426e626df41ba22ab7c451c3c2b5f455a11048b6"

      # Install the binary
      binary "wendy-cli-linux-static-musl-x86_64/wendy"
    end
  end
end
