class Luxc < Formula
  desc "A small teaching language that runs anywhere and transpiles to Rust, Swift, and Go"
  homepage "https://anderix.com/lux/"
  version "0.19.14"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.19.14/luxc-aarch64-apple-darwin.tar.xz"
      sha256 "879ad1df2950981d13eca17fe06f4d4d6edd41e1983924a857ba331cd9f78990"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.19.14/luxc-x86_64-apple-darwin.tar.xz"
      sha256 "a69a54850c9ff948367409e8cd2df53bce6e377017d6ab25d5e2455b11c4a21f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.19.14/luxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c95cb8ebf4e249e5524494a520facc1cf0e440f1f5660b56fd684ddb6c034482"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.19.14/luxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8f3e5ee027d73a9263e530afaf0d2bc94ec54adeedbab20cb7ced9a06950522b"
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
