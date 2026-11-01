class Luxc < Formula
  desc "A small teaching language that runs anywhere and transpiles to Rust, Swift, and Go"
  homepage "https://anderix.com/lux/"
  version "0.21.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.21.0/luxc-aarch64-apple-darwin.tar.xz"
      sha256 "724cf2864bd8feb79190db3bc537fabf386c848c1a4cae03f2381ab9743b0b24"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.21.0/luxc-x86_64-apple-darwin.tar.xz"
      sha256 "0d58e5a54edacb14ea5255b1d7278f6445af89f17e3b78289ade52e9bf14e4a2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.21.0/luxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "94a2a7a45d2d8344e83eed1917e95facddbb3268e0f0aec39eb3b5a2c28bab12"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.21.0/luxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "de88c9ac438926dbf433f3d454e5fac1c8b618988f157471abff81891c344987"
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
