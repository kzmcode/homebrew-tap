# メンテナンス手順（管理者向け）

利用者向けの説明は [README.md](README.md) を参照してください。

## フォルダ構成

```
homebrew-tap/
├── Casks/        # .app を配布するアプリ（1アプリ = 1ファイル: <名前>.rb）
├── Formula/      # コマンドラインツール（1ツール = 1ファイル: <名前>.rb）
└── .github/workflows/check.yml   # push / PR 時に brew style・brew audit を実行
```

- ファイル名（拡張子を除く）が `brew install` で指定する名前になる。**Tap 内で重複させない。**
- 配布ファイル（zip 等）はこのリポジトリに置かず、**各アプリのリポジトリの GitHub Releases** に置く。ここには `.rb` だけを置く。
- `version` と `sha256` はファイルごとに独立しているので、アプリごとに別々に更新できる。

## 新しいアプリを追加する

1. アプリのリポジトリで GitHub Release を作り、配布ファイル（例：`MyApp-1.0.0-arm64.zip`）を添付する
2. `Casks/<名前>.rb`（CLI なら `Formula/<名前>.rb`）を追加する
   - 雛形の作成：`brew create --cask <配布ファイルのURL> --tap kzmcode/tap`
3. 書式を確認する
   ```bash
   brew style --fix Casks/<名前>.rb
   brew audit --cask --online kzmcode/tap/<名前>
   ```
4. README.md の「収録アプリ」の表と、アプリ別の注意事項に追記してコミット・push する
5. GitHub Actions（check）が成功することを確認する

## アプリを更新する

各アプリのリポジトリで新しい Release を作り、対応する `.rb` の `version` と `sha256` を更新してコミットする。

- HoldNote：holdnote リポジトリで次を実行する
  ```bash
  scripts/update-cask.sh --org kzmcode ../homebrew-tap/Casks/holdnote.rb
  ```
