class Luxc < Formula
  desc "A small teaching language that runs anywhere and transpiles to Rust, Swift, and Go"
  homepage "https://anderix.com/lux/"
  version "0.19.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.19.15/luxc-aarch64-apple-darwin.tar.xz"
      sha256 "65d2aa469e99a9d980cc98970c948e04fb77f20848d15b60e0e71e638e0946c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.19.15/luxc-x86_64-apple-darwin.tar.xz"
      sha256 "531609e5a76a8828f75f7a5a4f0b80767147612146c65eb014e45ecb4589e239"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.19.15/luxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b3e52d14210aed380a56ceb3308da287b29f9731108726433882cb0305747666"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.19.15/luxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cf07256abec4e0999f42400fe5e8648918a88a884b64658fd264f7db67a67414"
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
    bin.install "lux" if OS.mac? && Hardware::CPU.arm?
    bin.install "lux" if OS.mac? && Hardware::CPU.intel?
    bin.install "lux" if OS.linux? && Hardware::CPU.arm?
    bin.install "lux" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
