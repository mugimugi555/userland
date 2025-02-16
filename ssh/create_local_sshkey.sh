#!/bin/bash

SSH_DIR="$HOME/.ssh"
KEY_FILE="$SSH_DIR/id_rsa_userland"

# 1. .ssh ディレクトリがなければ作成
if [ ! -d "$SSH_DIR" ]; then
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
fi

# 2. 既存の SSH キーを確認
if [ -f "$KEY_FILE" ]; then
    echo "既に SSH キーが存在します: $KEY_FILE"
    echo "上書きせずに処理を終了します。"
    exit 0
fi

# 3. SSH キーの作成（パスフレーズなし）
echo "UserLAnd 用の SSH キーを作成します..."
ssh-keygen -t rsa -b 4096 -f "$KEY_FILE" -N ""

# 4. パーミッションの設定
chmod 600 "$KEY_FILE"
chmod 644 "$KEY_FILE.pub"

# 5. 公開鍵の内容を表示
echo "SSH キーの作成が完了しました！"
echo "公開鍵の内容:"
cat "$KEY_FILE.pub"

echo "SSH キーを ~/.ssh/ に保存しました。"
