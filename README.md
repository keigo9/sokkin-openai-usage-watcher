# 📊 openai-usage-watcher

OpenAI API の利用額を毎日自動チェックして、一定額ごとに Slack 通知する GitHub Actions プロジェクトです！

## ✨ 特徴

- OpenAI の Usage API を使用して前日分の利用料を取得
- $5 ごとに Slack 通知を送信（変更可能）
- GitHub Actions で毎日自動実行
- cron 不要＆無料運用 OK！

## 🚀 セットアップ手順

### 1. このリポジトリをクローン / 作成

```bash
git clone https://github.com/yourname/openai-usage-watcher.git
```

### 2. GitHub Secrets の設定

リポジトリの「Settings」>「Secrets and variables」>「Actions」から以下を追加：

| 名前                | 説明                          |
| ------------------- | ----------------------------- |
| `OPENAI_API_KEY`    | OpenAI の API キー（sk-xxx）  |
| `SLACK_WEBHOOK_URL` | Slack の Incoming Webhook URL |

### 3. GitHub Actions 有効化

1 回 Push すれば `.github/workflows/check-usage.yml` が自動で実行されるよ！

## 🛠 カスタマイズ

- 通知間隔を変えたい場合は `scripts/check-usage.sh` 内の `THRESHOLD` を変更
- 通知メッセージもここで編集できるよ！

## 🧪 手動実行も可能！

Actions タブ → `Check OpenAI Usage` → `Run workflow` でいつでも実行できるよ！

---
