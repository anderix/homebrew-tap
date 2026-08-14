class Luxc < Formula
  desc "A small teaching language that runs anywhere and transpiles to Rust, Swift, and Go"
  homepage "https://anderix.com/lux/"
  version "0.19.17"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.19.17/luxc-aarch64-apple-darwin.tar.xz"
      sha256 "7edd9bf76d1d193ea142a18f040d17bba337acc3e865f2d47930f86edd84aaa7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.19.17/luxc-x86_64-apple-darwin.tar.xz"
      sha256 "bb4d4dc049133823b2f09210e7d3a0fb2a37ae5000ed3602ff67d245f30bf8ef"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.19.17/luxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c24e008cea05b2a720811a2783481983864dab4c21e42ea4cb75d7b84bea8ae4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.19.17/luxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "038b59e20d246f2edc86f1bc27266a0f725804edfa0acad2ae8c40e06e6aac0b"
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
