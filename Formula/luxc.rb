class Luxc < Formula
  desc "A small teaching language that runs anywhere and transpiles to Rust, Swift, and Go"
  homepage "https://anderix.com/lux/"
  version "0.20.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.20.1/luxc-aarch64-apple-darwin.tar.xz"
      sha256 "28dfbeab0f4a5e542ee5822bde19a81be10669920dd3cc3a09d441fc4614c709"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.20.1/luxc-x86_64-apple-darwin.tar.xz"
      sha256 "1d07bedf2297affaf8a94e0a07cd6ee65232c658c43bace8eae75d06dcfa8a58"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.20.1/luxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8b10b2f707ed74d2a405674a45c85c0a4de0d62a55ac3ee3a84787938de48f65"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.20.1/luxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e91027cef83fa6aab95ad5599c55317ac8ca1a3d51f908bfcb2bbae5581d1eba"
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
