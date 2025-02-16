#!/bin/bash

# ADB で接続中のすべてのデバイスを取得
devices=$(adb devices | awk 'NR>1 && $1!="" {print $1}')

if [ -z "$devices" ]; then
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
    "ls -al /data/local/tmp/id_rsa_userland.pub"
    "cat /data/local/tmp/id_rsa_userland.pub >> ~/.ssh/authorized_keys"
    "chmod 600 ~/.ssh/authorized_keys"
    # "rm /data/local/tmp/id_rsa_userland.pub" #permission denied
)

echo "接続されているデバイス: $devices"
echo "=== デバッグ: 送信するコマンド一覧 ==="
printf "%s\n" "${cmd_list[@]}"
echo "==================================="

# すべての端末に対してコマンドを送信
for device in $devices; do
    echo "デバイス ($device) にコマンドを送信中..."

    for cmd in "${cmd_list[@]}"; do
        echo "デバッグ: [$device] 実行コマンド -> [$cmd]"

        cmd_escaped=$(adb_escape_text "$cmd")
        echo "エスケープ前: $cmd"
        echo "エスケープ後: $cmd_escaped"

        echo "送信中: $cmd_escaped"

        adb -s "$device" shell input text "$cmd_escaped"
        adb -s "$device" shell input keyevent 66  # Enterキーを送信
        sleep 0.5  # コマンド処理のための短い待機
    done
done

echo "すべてのデバイスへのコマンド送信が完了しました。"
