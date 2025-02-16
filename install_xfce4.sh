#!/bin/bash

echo "=========================================="
echo "🚀 UserLAnd XFCE4 + VNC 自動セットアップ"
echo "=========================================="

# ======================================================================
# 必要なパッケージをインストール
# ======================================================================
echo "📌 必要なパッケージをインストール中..."
sudo apt update
sudo apt install -y xfce4 xfce4-goodies tightvncserver dbus-x11

# ======================================================================
# VNC の初期設定
# ======================================================================
echo "📌 VNC 初回起動..."
vncserver :1
echo "✅ VNC パスワードを設定してください。view-only パスワードは不要なので 'n' を入力"

# ======================================================================
# VNC 設定を変更（xfce4 を使用するように設定）
# ======================================================================
echo "📌 VNC の xstartup を XFCE4 に変更..."
mkdir -p ~/.vnc
cat <<EOF > ~/.vnc/xstartup
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

# ======================================================================
# VNC を起動
# ======================================================================
echo "📌 VNC サーバーを起動..."
vncserver :1 -geometry 1280x720 -depth 24

# ======================================================================
# VNC の接続情報を表示
# ======================================================================
echo "=========================================="
echo "✅ インストール完了！"
echo "📡 VNC クライアントで接続してください:"
echo "   アドレス: localhost:5901"
echo "   解像度  : 1280x720"
echo "   色深度  : 24-bit"
echo "=========================================="
echo "🔄 VNC を停止する場合は次のコマンドを実行してください:"
echo "   vncserver -kill :1"
echo "=========================================="
