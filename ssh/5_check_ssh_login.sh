#!/bin/bash

SSH_USER="userland"  # SSH のユーザー名（UserLAnd 側で使用するユーザー名）
SSH_KEY="$HOME/.ssh/android_id_rsa"  # ローカルの SSH 秘密鍵
SSH_PORT="2022"  # SSH のポート番号（UserLAnd 側の SSH サーバーのポート）

echo "接続中の Android 端末の IP アドレスを取得しています..."

# 自分のローカル IP アドレスを取得
local_ip=$(ip route get 8.8.8.8 | awk '{print $7}')
network_prefix=$(echo "$local_ip" | awk -F'.' '{print $1"."$2"."$3"."}')  # 例: 192.168.1.

echo "自分の IP アドレス: $local_ip"
echo "ネットワーク範囲: ${network_prefix}*"

# ADB で接続中のデバイスを取得
devices=$(adb devices | awk 'NR>1 && $1!="" {print $1}')

if [ -z "$devices" ]; then
    echo "エラー: 接続されている Android デバイスが見つかりません。"
    exit 1
fi

echo "=========================================="
echo " デバイスID         IPアドレス        ステータス"
echo "=========================================="

# 各デバイスの IP アドレスを取得し、ネットワーク範囲内のものだけを使用
for device in $devices; do
    ip_candidates=$(adb -s "$device" shell ip route | awk '{print $9}' | grep "^${network_prefix}")

    if [[ -n "$ip_candidates" ]]; then
        ip_address=$(echo "$ip_candidates" | head -n 1)  # 最初の一致を取得
    else
        echo " $device      取得不可         ❌ IPアドレス取得失敗"
        continue
    fi

    # SSH ホストキーを削除（警告を回避）
    ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[$ip_address]:$SSH_PORT" > /dev/null 2>&1

    # SSH ログインを試行
    echo " $device      $ip_address      SSH 接続試行中 (ポート: $SSH_PORT)..."

    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=5 -i "$SSH_KEY" -p "$SSH_PORT" "$SSH_USER@$ip_address" "echo 'SSH 接続成功: $device ($ip_address)'"

    if [ $? -eq 0 ]; then
        echo " ✅ 成功: $device ($ip_address) に SSH ログインしました。"
    else
        echo " ❌ 失敗: $device ($ip_address) に SSH ログインできませんでした。"
    fi
done

echo "=========================================="
echo "全端末の SSH 接続処理が完了しました。"
