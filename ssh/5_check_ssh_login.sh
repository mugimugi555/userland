#!/bin/bash

SSH_USER="userland"  # SSH のユーザー名（UserLAnd 側で使用するユーザー名）
SSH_KEY="$HOME/.ssh/android_id_rsa"  # ローカルの SSH 秘密鍵

echo "接続中の Android 端末の IP アドレスを取得しています..."

# ADB で接続中のデバイスを取得
devices=$(adb devices | awk 'NR>1 && $1!="" {print $1}')

if [ -z "$devices" ]; then
    echo "エラー: 接続されている Android デバイスが見つかりません。"
    exit 1
fi

echo "=========================================="
echo " デバイスID         IPアドレス        ステータス"
echo "=========================================="

# 各デバイスの IP アドレスを取得し SSH 接続を試みる
for device in $devices; do
    ip_address=$(adb -s "$device" shell ip route | awk '{print $9}' | head -n 1)

    if [[ -z "$ip_address" || "$ip_address" == "0.0.0.0" ]]; then
        echo " $device      取得不可         ❌ IPアドレス取得失敗"
        continue
    fi

    # SSH ログインを試行
    echo " $device      $ip_address      SSH 接続試行中..."
    
    ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 -i "$SSH_KEY" "$SSH_USER@$ip_address" "echo 'SSH 接続成功: $device ($ip_address)'"
    
    if [ $? -eq 0 ]; then
        echo " ✅ 成功: $device ($ip_address) に SSH ログインしました。"
    else
        echo " ❌ 失敗: $device ($ip_address) に SSH ログインできませんでした。"
    fi
done

echo "=========================================="
echo "全端末の SSH 接続処理が完了しました。"
