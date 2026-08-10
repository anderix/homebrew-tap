class Luxc < Formula
  desc "A small teaching language that runs anywhere and transpiles to Rust, Swift, and Go"
  homepage "https://anderix.com/lux/"
  version "0.19.16"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.19.16/luxc-aarch64-apple-darwin.tar.xz"
      sha256 "8ec5bd72fe68f81b7fb0d63ae38c75400bc023e11afc591706a04f92d761e81e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.19.16/luxc-x86_64-apple-darwin.tar.xz"
      sha256 "a2f5b57cc37543c2e95b6e844934fe56a8c0b1e4b64adfa87bb2a0081ae2c156"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anderix/lux/releases/download/v0.19.16/luxc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "993685d473dc3ff3c989a82f0ed05cfcdefeaf9739e4a1f046f820b6910c1dae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anderix/lux/releases/download/v0.19.16/luxc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b76f25536b7238e5e04577679e21be11c4c82f775d861c35e357976f4d55e5fb"
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
