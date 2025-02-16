#!/bin/bash

echo "接続中の Android 端末の IP アドレス一覧を取得します..."

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

echo "=============================="
echo " デバイスID         IPアドレス"
echo "=============================="

# 各デバイスの IP アドレスを取得し、ネットワーク範囲内のものだけを表示
for device in $devices; do
    ip_candidates=$(adb -s "$device" shell ip route | awk '{print $9}' | grep "^${network_prefix}")

    if [[ -n "$ip_candidates" ]]; then
        ip_address=$(echo "$ip_candidates" | head -n 1)  # 最初の一致を取得
    else
        ip_address="取得不可"
    fi

    printf " %-15s %-15s\n" "$device" "$ip_address"
done

echo "=============================="
