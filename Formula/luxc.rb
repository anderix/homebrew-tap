class Luxc < Formula
  desc "A small teaching language that runs anywhere and transpiles to Rust, Swift, and Go"
  homepage "https://anderix.com/lux/"
  version "0.19.18"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.19.18/luxc-aarch64-apple-darwin.tar.xz"
      sha256 "d7fb24044fe8b8c4465dc733431c4d58cfaf40ae35d49f4a10e4afa170b22984"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.19.18/luxc-x86_64-apple-darwin.tar.xz"
      sha256 "6a7089ba235d0bdc56528c3e09a2b5bd557ac59acbc225b61c17cbefa1f9ef3f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.19.18/luxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6b7ff2a72c0b5b2389945b844ffa794756341c23cb73a649b54e03245e7857ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.19.18/luxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "01e767abbbe8baf181bc9b2d1f4e326327087d162d186ee38c4613383845af9a"
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
