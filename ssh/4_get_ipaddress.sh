#!/bin/bash

echo "接続中の Android 端末の IP アドレス一覧を取得します..."

# ADB で接続中のデバイスを取得
devices=$(adb devices | awk 'NR>1 && $1!="" {print $1}')

if [ -z "$devices" ]; then
    echo "エラー: 接続されている Android デバイスが見つかりません。"
    exit 1
fi

echo "=============================="
echo " デバイスID         IPアドレス"
echo "=============================="

# 各デバイスの IP アドレスを取得
for device in $devices; do
    ip_address=$(adb -s "$device" shell ip route | awk '{print $9}' | head -n 1)

    if [[ -z "$ip_address" || "$ip_address" == "0.0.0.0" ]]; then
        ip_address="取得不可"
    fi

    printf " %-15s %-15s\n" "$device" "$ip_address"
done

echo "=============================="
