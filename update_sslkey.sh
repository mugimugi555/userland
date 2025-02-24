#!/bin/bash

echo "=========================================="
echo "🚀 CA 証明書の更新スクリプト"
echo "=========================================="

# ======================================================================
# 必要なパッケージの更新
# ======================================================================
echo "📌 パッケージリストを更新中..."
sudo apt update -y

# ======================================================================
# CA 証明書の再インストール
# ======================================================================
echo "📌 CA 証明書 (ca-certificates) を再インストール中..."
sudo apt install --reinstall -y ca-certificates

# ======================================================================
# 完了メッセージ
# ======================================================================
echo "=========================================="
echo "🎉 CA 証明書の更新が完了しました！"
echo "=========================================="
