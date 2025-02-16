#!/bin/bash

# ADB で接続中のデバイスを取得
device=$(adb devices | awk 'NR==2 {print $1}')

if [ -z "$device" ]; then
    echo "エラー: 接続されている Android デバイスが見つかりません。"
    exit 1
fi

# ADB の input text コマンド用エスケープ関数
adb_escape_text() {
    local text="$1"

    # `sed` を使って ADB に適したエスケープ処理
    text=$(echo "$text" | sed -E "
        s/-/\-/g;
        s/ /%s/g;
        s/>/\\\\>/g;
    ")
    #'\\' => '\\\\',
    #'%'  => '\\%',
    #' '  => '%s',
    #'"'  => '\\"',
    #"'"  => "\\'",
    #'('  => '\\(',
    #')'  => '\\)',
    #'&'  => '\\&',
    #'<'  => '\\<',
    #'>'  => '\\>',
    #';'  => '\\;',
    #'*'  => '\\*',
    #'|'  => '\\|',
    #'~'  => '\\~',
    #'¬'  => '\\¬',
    #'`'  => '\\`'

    echo "$text"
}

# 送信するコマンドを配列として定義
cmd_list=(
    "rm -rf ~/.ssh"
    "mkdir -p ~/.ssh"
    "chmod 700 ~/.ssh"
    "touch ~/.ssh/authorized_keys"
    "cat /data/local/tmp/id_rsa_userland.pub >> ~/.ssh/authorized_keys"
    "chmod 600 ~/.ssh/authorized_keys"
    "rm /data/local/tmp/id_rsa_userland.pub"
)

echo "デバイス ($device) にコマンドを送信します..."
echo "=== デバッグ: 送信するコマンド一覧 ==="
printf "%s\n" "${cmd_list[@]}"
echo "==================================="

# 各コマンドを 1 行ずつ送信
for cmd in "${cmd_list[@]}"; do
    echo "デバッグ: 現在のコマンド -> [$cmd]"

    cmd_escaped=$(adb_escape_text "$cmd")
    echo "エスケープ前: $cmd"
    echo "エスケープ後: $cmd_escaped"

    echo "送信中: $cmd_escaped"

    adb -s "$device" shell input text "$cmd_escaped"
    adb -s "$device" shell input keyevent 66  # Enterキーを送信
    sleep 0.5  # コマンド処理のための短い待機
done

echo "コマンドの送信が完了しました。"
