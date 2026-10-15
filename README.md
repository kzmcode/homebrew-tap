# kzmcode/homebrew-tap

kzmcode が公開している macOS アプリ・CLI ツールの Homebrew Tap です。

```bash
brew tap kzmcode/tap
```

## 収録アプリ

| 名前 | 種類 | インストール | 説明 | リポジトリ |
|---|---|---|---|---|
| HoldNote | Cask | `brew install --cask kzmcode/tap/holdnote` | ホットキー長押しで録音 → ローカル文字起こし → Google Drive に保存するメニューバーアプリ | [kzmcode/holdnote](https://github.com/kzmcode/holdnote) |

> 収録アプリは Apple の公証を受けていない場合があります。初回起動時に Gatekeeper にブロックされたら、
> **システム設定 → プライバシーとセキュリティ →「このまま開く」** で許可してください。各アプリの注意事項は `brew info --cask <名前>` で確認できます。

## フォルダ構成

```
homebrew-tap/
├── Casks/        # .app を配布するアプリ（1アプリ = 1ファイル: <名前>.rb）
├── Formula/      # コマンドラインツール（1ツール = 1ファイル: <名前>.rb）
└── .github/workflows/check.yml   # push / PR 時に brew style・brew audit を実行
```

- ファイル名（拡張子を除く）が `brew install` で指定する名前になります。**Tap 内で重複させないでください。**
- 各アプリのバイナリ（zip 等）はこのリポジトリに置かず、**各アプリのリポジトリの GitHub Releases** に置きます。ここには `.rb` だけを置きます。
- `version` と `sha256` はファイルごとに独立しているので、アプリごとに別々に更新できます。

## 新しいアプリを追加する

1. アプリのリポジトリで GitHub Release を作り、配布ファイル（例：`MyApp-1.0.0-arm64.zip`）を添付する
2. `Casks/<名前>.rb`（CLI なら `Formula/<名前>.rb`）を追加する
   - 雛形の作成：`brew create --cask <配布ファイルのURL> --tap kzmcode/tap`
3. 書式を確認する
   ```bash
   brew style --fix Casks/<名前>.rb
   brew audit --cask kzmcode/tap/<名前>
   ```
4. 上の「収録アプリ」の表に 1 行追加してコミット・push する

## アプリを更新する

各アプリのリポジトリの手順に従って新しい Release を作り、対応する `.rb` の `version` と `sha256` を更新してコミットします。
HoldNote は、holdnote リポジトリで次を実行すると更新されます。

```bash
scripts/update-cask.sh --org kzmcode ../homebrew-tap/Casks/holdnote.rb
```
