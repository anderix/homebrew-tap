class Luxc < Formula
  desc "A small teaching language that runs anywhere and transpiles to Rust, Swift, and Go"
  homepage "https://anderix.com/lux/"
  version "0.19.13"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.19.13/luxc-aarch64-apple-darwin.tar.xz"
      sha256 "595df46465ce515d48b90f2c205f8a2fc6f0fb98cca78216050cdd170a3bd7b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.19.13/luxc-x86_64-apple-darwin.tar.xz"
      sha256 "0c38d7baed3123c512fb9079aee5e37ed02704e90c9669320fce0f57cf932ae8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.19.13/luxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "61ef03088a6a8c2258e24185e8d5f24e808219d52de9e4fa3f53c6b2d1875ccb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.19.13/luxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c65fbe1697dff1e272cb68310b3741f6d67e002b5a1f8149c574deb6da3099b3"
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
