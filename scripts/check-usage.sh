# ==== 設定 ====
THRESHOLD=5  # $5ごとに通知
LAST_FILE="./scripts/last_usage.txt"

# ==== 日付設定 ====
TODAY=$(date +%F)
START_DATE=$(date -v1d -v-0H -v-0M -v-0S +%F)  # 昨日から今日の分だけチェック

# ==== Usage取得 ====
USAGE=$(curl -s "https://api.openai.com/v1/dashboard/billing/usage?start_date=${START_DATE}&end_date=${TODAY}" \
  -H "Authorization: Bearer $API_KEY" | jq '.total_usage / 100')

USAGE=$(printf "%.2f" "$USAGE")  # 小数第2位まで整形

# ==== 前回の利用額読み込み ====
if [ -f "$LAST_FILE" ]; then
  LAST=$(cat "$LAST_FILE")
else
  LAST=0
fi

DIFF=$(echo "$USAGE - $LAST" | bc)

# ==== 通知判定 ====
if (( $(echo "$DIFF >= $THRESHOLD" | bc -l) )); then
  echo "通知を送信中... (現在: $USAGE, 前回: $LAST)"
  curl -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"🚨 OpenAIの利用額が \$$USAGE に到達しました！（前回通知: \$$LAST）\"}" \
    "$SLACK_WEBHOOK_URL"

  echo "$USAGE" > "$LAST_FILE"
else
  echo "通知不要〜 (現在: $USAGE, 前回: $LAST)"
fi
