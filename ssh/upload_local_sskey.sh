#!/bin/bash

SSH_KEY="$HOME/.ssh/android_id_rsa.pub"
TARGET_PATH="/data/local/tmp/android_id_rsa.pub"

# SSH キーが存在するか確認
if [ ! -f "$SSH_KEY" ]; then
    echo "エラー: SSH 公開鍵 ($SSH_KEY) が見つかりません。"
    exit 1
fi

# ADB で接続中のデバイスを取得
devices=$(adb devices | awk 'NR>1 && $1!="" {print $1}')

if [ -z "$devices" ]; then
    echo "エラー: 接続されている Android デバイスが見つかりません。"
    exit 1
fi

# 各デバイスに SSH キーを送信
for device in $devices; do
    echo "デバイス ($device) に SSH キーをアップロード中..."
    adb -s "$device" push "$SSH_KEY" "$TARGET_PATH"

    if [ $? -eq 0 ]; then
        echo "✅ 成功: $device に SSH キーをアップロードしました。"
    else
        echo "❌ 失敗: $device に SSH キーをアップロードできませんでした。"
    fi
done

echo "すべてのデバイスへの SSH キーのアップロードが完了しました。"
