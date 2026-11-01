class Luxc < Formula
  desc "A small teaching language that runs anywhere and transpiles to Rust, Swift, and Go"
  homepage "https://anderix.com/lux/"
  version "0.20.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.20.0/luxc-aarch64-apple-darwin.tar.xz"
      sha256 "0a50cddaa6349edcb56aa69e170cc78b4dc193e76431e21e2f4d1dff4a2bd3f9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.20.0/luxc-x86_64-apple-darwin.tar.xz"
      sha256 "4340c2e1856cda0b9e02b74b049c93e10ba70f3e9e8dae8c12016f4325f9561b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.20.0/luxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "13dd7ac1ba6bf90326cf0f7fcb36fa45a8afed5be10e992d1376a8edd5bd1d09"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.20.0/luxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2bbaf898cd38482e207b00b2e0d35116f53e0338dd817c90c8b2ff08eeec7f9e"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "lux"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lux"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "lux"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lux"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
