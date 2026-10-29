class Qivmi < Formula
  desc "Gmail chat viewer for macOS (Tauri)"
  homepage "https://github.com/kzmcode/qivmi"
  url "https://github.com/kzmcode/qivmi/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "aba2046e647f28b4fc74ba4e22ddf3af7745fe71df459d3b62bf141384b4677a"
  license "MIT"

  # Build dependencies. Xcode Command Line Tools are also required
  # (`xcode-select --install`).
  depends_on "node" => :build
  depends_on "rust" => :build
  depends_on macos: :ventura

  def install
    system "npm", "ci"
    system "npx", "tauri", "build", "--bundles", "app"
    prefix.install "src-tauri/target/release/bundle/macos/Qivmi.app"
    bin.install_symlink prefix/"Qivmi.app/Contents/MacOS/qivmi"
  end

  def caveats
    <<~EOS
      Place the app in ~/Applications and finish the Gmail setup:

        qivmi install-app
        qivmi setup

      After `brew upgrade qivmi`, run `qivmi install-app` again.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qivmi --version")
  end
end
