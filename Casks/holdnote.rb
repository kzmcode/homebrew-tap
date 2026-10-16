# HoldNote — https://github.com/kzmcode/holdnote
# Updated by `scripts/update-cask.sh --org kzmcode` in the holdnote repository.
cask "holdnote" do
  version "0.1.2"
  sha256 "d3ab379dc18a7137416b870e2e76ef0222098fef9fba743477940e9adc622941"

  url "https://github.com/kzmcode/holdnote/releases/download/v#{version}/HoldNote-#{version}-arm64.zip"
  name "HoldNote"
  desc "Hold-to-record voice memo menu bar app with local transcription"
  homepage "https://github.com/kzmcode/holdnote"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  # Optional: install the whisper.cpp CLI via Homebrew instead of bundling it in the app.
  # Uncomment if the release zip does NOT include Contents/Resources/bin/whisper-cli.
  # depends_on formula: "whisper.cpp"

  app "HoldNote.app"

  zap trash: [
    "~/Library/Application Support/HoldNote",
    "~/Library/LaunchAgents/io.github.holdnote.HoldNote.plist",
  ]

  caveats <<~EOS
    HoldNote is ad-hoc signed and not notarized by Apple. On first launch macOS
    Gatekeeper will block it. To approve it:
      1. Try to open HoldNote once (it will be blocked).
      2. Open System Settings > Privacy & Security, scroll to the Security section
         and click "Open Anyway" next to HoldNote, then confirm.

    HoldNote needs Microphone permission (and any other permission it prompts for).
    After upgrading, macOS may ask you to grant these permissions again because the
    ad-hoc signature changes with every build.
  EOS
end
