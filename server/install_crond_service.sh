#!/bin/bash

echo "=========================================="
echo "🚀 UserLAnd のサービスを自動起動設定するスクリプト"
echo "=========================================="

# ======================================================================
# `cron` をインストール & 起動
# ======================================================================
echo "📌 cron のインストールを確認..."
if ! command -v cron &> /dev/null; then
    echo "📌 cron がインストールされていません。インストール中..."
    sudo apt update
    sudo apt install -y cron
fi

echo "📌 cron を起動..."
sudo service cron start

# ======================================================================
# 起動可能なサービスを検出
# ======================================================================
SERVICES=("mysql" "apache2" "nginx" "php-fpm")
AUTOSTART_COMMANDS=()

echo "📌 インストール済みのサービスを確認..."
for SERVICE in "${SERVICES[@]}"; do
    if command -v $SERVICE &> /dev/null || sudo service --status-all 2>&1 | grep -q "$SERVICE"; then
        echo "✅ $SERVICE はインストールされています。"
        AUTOSTART_COMMANDS+=("sudo service $SERVICE start")
    else
        echo "❌ $SERVICE はインストールされていません。"
    fi
done

# ======================================================================
# `cron` に自動起動タスクを追加
# ======================================================================
if [ ${#AUTOSTART_COMMANDS[@]} -gt 0 ]; then
    echo "📌 `cron` にサービスの自動起動を追加..."
    
    # 既存の crontab にある `@reboot` を削除（重複防止）
    crontab -l 2>/dev/null | grep -v "@reboot" > /tmp/crontab_backup

    # 自動起動のコマンドを追加
    for CMD in "${AUTOSTART_COMMANDS[@]}"; do
        echo "@reboot $CMD" >> /tmp/crontab_backup
    done

    # `cron` に反映
    crontab /tmp/crontab_backup
    rm /tmp/crontab_backup

    echo "✅ `cron` にサービスの自動起動を登録しました！"
else
    echo "⚠️ 起動するサービスが見つかりませんでした。"
fi

# ======================================================================
# `.bashrc` に `cron` の自動起動を追加
# ======================================================================
echo "📌 `.bashrc` に cron の自動起動を追加..."
if ! grep -q "service cron start" ~/.bashrc; then
    echo "sudo service cron start" >> ~/.bashrc
    echo "✅ `.bashrc` に cron の自動起動を設定しました！"
else
    echo "✅ `.bashrc` にはすでに cron の自動起動設定があります。"
fi

# ======================================================================
# 確認メッセージ
# ======================================================================
echo "=========================================="
echo "✅ 設定が完了しました！"
echo "💡 UserLAnd のセッションを再起動すると、自動で以下のサービスが開始されます。"
echo "=========================================="
for SERVICE in "${SERVICES[@]}"; do
    if command -v $SERVICE &> /dev/null || sudo service --status-all 2>&1 | grep -q "$SERVICE"; then
        echo "🚀 $SERVICE"
    fi
done
echo "=========================================="
