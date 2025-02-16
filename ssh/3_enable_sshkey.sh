#!/bin/bash

# ADB で接続中のデバイスを取得
device=$(adb devices | awk 'NR==2 {print $1}')

if [ -z "$device" ]; then
    echo "エラー: 接続されている Android デバイスが見つかりません。"
    exit 1
fi

# 送信するコマンドをヒアドキュメントで定義
cmd=$(cat <<EOF
rm -rf ~/.ssh;
mkdir -p ~/.ssh;
chmod 700 ~/.ssh;
cat /data/local/tmp/id_rsa_userland.pub >> ~/.ssh/authorized_keys;
chmod 600 ~/.ssh/authorized_keys;
rm /data/local/tmp/id_rsa_userland.pub
EOF
)

# スペースをエスケープ（ADB はスペースを `\ ` にしないと認識しない）
cmd_escaped=$(echo "$cmd" | sed 's/ /\\ /g')

# UserLAnd にテキスト送信
echo "デバイス ($device) にコマンドを送信します..."
adb -s "$device" shell input text "$cmd_escaped"
adb -s "$device" shell input keyevent 66  # Enterキーを送信

echo "コマンドの送信が完了しました。"
