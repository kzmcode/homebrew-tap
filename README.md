# kzmcode/homebrew-tap

[kzmcode](https://github.com/kzmcode) が開発している Mac アプリを、[Homebrew](https://brew.sh/ja/) でインストールするためのリポジトリです。

## 収録アプリ

| アプリ | 説明 | 対応環境 | インストール |
|---|---|---|---|
| [HoldNote](https://github.com/kzmcode/holdnote) | ホットキーを押している間だけ録音し、Mac 上で文字起こしして Google Drive に保存するメニューバーアプリ | Apple Silicon・macOS 14 以降 | `brew install --cask kzmcode/tap/holdnote` |
| [Qivmi](https://github.com/kzmcode/qivmi) | Gmail のメールを相手ごとにまとめ、チャット形式で閲覧・送信するアプリ | macOS 13 以降 | `brew install kzmcode/tap/qivmi` |

## はじめに：Homebrew の準備

Homebrew が入っていない場合は、[公式サイト](https://brew.sh/ja/)の手順でインストールしてください。
インストール済みかどうかは、ターミナルで次を実行して確認できます。

```bash
brew --version
```

## インストール

```bash
brew install --cask kzmcode/tap/holdnote   # HoldNote
brew install kzmcode/tap/qivmi             # Qivmi（ソースからビルド。下の注意事項を参照）
```

アプリ名の前に `kzmcode/tap/` を付けると、このリポジトリが自動で追加されます（`brew tap kzmcode/tap` を先に実行しても同じです）。

### 初回起動時の許可（重要）

HoldNote は Apple の公証を受けていないため、初回起動時に macOS（Gatekeeper）にブロックされます。次の手順で許可してください。

1. アプリを一度開く（「開けません」と表示されたら閉じる）
2. **システム設定 → プライバシーとセキュリティ** を開き、下の方の「セキュリティ」欄にある **「このまま開く」** を押す
3. 確認画面で「開く」を押す

一度許可すれば、次回からは普通に起動できます。
Gatekeeper を無効にしたり、ターミナルで隔離属性を外したりする必要はありません。

Qivmi はお使いの Mac 上でソースからビルドするため、この手順は不要です。

## アップデート・アンインストール

```bash
brew upgrade --cask kzmcode/tap/holdnote        # 最新版に更新
brew uninstall --cask kzmcode/tap/holdnote      # アプリを削除（設定・履歴は残る）
brew uninstall --zap --cask kzmcode/tap/holdnote  # 設定・履歴など関連ファイルもすべて削除
```

Qivmi の更新・削除は「アプリ別の注意事項」を参照してください。

## アプリ別の注意事項

### HoldNote

- **Google Drive への保存には事前準備が必要です。** Google Cloud で OAuth クライアントを作成し、アプリの設定画面に入力します。手順：[Google Cloud の準備](https://github.com/kzmcode/holdnote/blob/main/docs/google-cloud-setup.md)
- **音声認識モデル** は、初回にアプリの設定画面「音声認識」タブからダウンロードします（約 150MB）。文字起こしエンジン（whisper.cpp）はアプリに同梱されています。
- **マイクの許可** を求められたら「許可」を押してください。アップデート後に再度求められることがあります。
- 録音は macOS の **既定の入力デバイス** で行います。音が入らない場合は、システム設定 → サウンド → 入力 で使いたいマイクを選んでください。
- 使い方・詳しい説明：[HoldNote ユーザーマニュアル](https://github.com/kzmcode/holdnote/blob/main/docs/user-manual.md)
- うまく動かないときは、ターミナルで `/Applications/HoldNote.app/Contents/MacOS/holdnote --doctor` を実行すると原因を診断できます（v0.1.1 以降）

### Qivmi

- **ソースからビルドします。** 事前に Xcode Command Line Tools（`xcode-select --install`）が必要です。初回のビルドには 5〜15 分かかり、ビルド中は 2〜3GB ほどのディスクを使います。
- インストール後、次を実行してアプリを配置し、Gmail の初期設定をします。
  ```bash
  qivmi install-app   # ~/Applications/Qivmi.app に配置
  qivmi setup         # Google Cloud の設定と Gmail ログイン
  ```
- **Gmail の利用には事前準備が必要です。** 各自の Google Cloud プロジェクトで OAuth クライアントを作成します（無料）。`qivmi setup` が手順を案内します。詳細：[GCP セットアップ](https://github.com/kzmcode/qivmi#gcp-セットアップ利用者ごとすべて無料)
- 更新は `brew upgrade qivmi` の後に `qivmi install-app` を再実行します。削除は `qivmi uninstall-app` → `brew uninstall qivmi`（ローカルデータと認証情報も消す場合は先に `qivmi reset --all`）。
- [プライバシーポリシー](https://kzmcode.github.io/qivmi/privacy)

## 困ったとき

| 症状 | 対処 |
|---|---|
| `brew install` で「It seems there is already an App at ...」と出る | 手動で入れた同名のアプリがあります。`/Applications` から削除してから再実行してください |
| 「開発元を検証できないため開けません」と出る | 上記「初回起動時の許可」の手順で許可してください |
| `Error: Cask 'holdnote' is unavailable` などと出る | `brew update` を実行してから再度お試しください |
| アプリが起動しない・動作がおかしい | 各アプリのリポジトリの Issues に、macOS のバージョンと症状を書いて報告してください（[HoldNote の Issues](https://github.com/kzmcode/holdnote/issues)、[Qivmi の Issues](https://github.com/kzmcode/qivmi/issues)） |

## 安全性について

- 配布ファイルは各アプリのリポジトリの GitHub Releases（Qivmi はタグのソースコード）から直接ダウンロードされます。Homebrew がファイルの SHA-256 を照合し、一致しない場合はインストールを中止します。
- 各アプリのソースコードは、それぞれのリポジトリで公開しています。

## ライセンス

各アプリのライセンスは、それぞれのリポジトリを参照してください。

---

管理者向けの手順は [MAINTAINING.md](MAINTAINING.md) にあります。
