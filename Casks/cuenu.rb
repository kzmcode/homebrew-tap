# Cuenu — https://github.com/kzmcode/cuenu
# Updated by .github/workflows/release-desktop.yml in the cuenu repository.
cask "cuenu" do
  version "0.1.2"
  sha256 "cb5bf479ec82e5c66c8ac2220e5724e216921d91865d369abb6890d7eed724ed"

  url "https://github.com/kzmcode/cuenu/releases/download/v#{version}/Cuenu_#{version}_aarch64.dmg"
  name "Cuenu"
  desc "Personal memo timeline with AI suggestions for a self-hosted server"
  homepage "https://github.com/kzmcode/cuenu"

  # Apple Silicon のみ（Intel / Universal Binary は未対応・未検証）
  depends_on arch: :arm64
  depends_on :macos

  app "Cuenu.app"

  # identifier（tauri.conf.json）を変更した場合はここのパスも合わせる
  zap trash: [
    "~/Library/Application Support/io.github.kzmcode.cuenu",
    "~/Library/Caches/io.github.kzmcode.cuenu",
    "~/Library/HTTPStorages/io.github.kzmcode.cuenu",
    "~/Library/Preferences/io.github.kzmcode.cuenu.plist",
    "~/Library/Saved Application State/io.github.kzmcode.cuenu.savedState",
    "~/Library/WebKit/io.github.kzmcode.cuenu",
  ]

  caveats <<~EOS
    Cuenu is ad-hoc signed and not notarized by Apple. On first launch macOS
    Gatekeeper will block it. To approve it:
      1. Try to open Cuenu once (it will be blocked).
      2. Open System Settings > Privacy & Security, scroll to the Security section
         and click "Open Anyway" next to Cuenu, then confirm.

    On first launch, enter the URL of your own Cuenu server and its owner password.
    The screenshot button needs Screen Recording permission. After upgrading, macOS
    may ask for Screen Recording and Keychain access again because the ad-hoc
    signature changes with every build. Notes and settings are kept on uninstall;
    use `brew uninstall --zap --cask cuenu` to remove them.
  EOS
end
