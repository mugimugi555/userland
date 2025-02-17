#!/bin/bash

echo "=========================================="
echo "🚀 Xvfb + VNC + XFCE4 + xfce4-goodies + 日本語キーボード設定"
echo "=========================================="

# ======================================================================
# キーボードレイアウトを日本語に設定（インストール前に適用）
# ======================================================================
echo "📌 キーボードレイアウトを日本語 (Japanese) に変更中..."
sudo debconf-set-selections <<EOF
keyboard-configuration keyboard-configuration/layoutcode string jp
keyboard-configuration keyboard-configuration/modelcode string pc105
keyboard-configuration keyboard-configuration/xkb-keymap select jp
EOF

# ======================================================================
# 必要なパッケージをインストール
# ======================================================================
echo "📌 必要なパッケージをインストール中..."
sudo apt update
sudo apt install -y console-setup keyboard-configuration dbus-x11 \
                     xvfb x11-xserver-utils xauth \
                     tigervnc-standalone-server \
                     xfce4 xfce4-goodies 

# 日本語設定を再適用
sudo dpkg-reconfigure -f noninteractive keyboard-configuration
sudo localectl set-keymap jp
sudo service keyboard-setup restart

# ======================================================================
# `.Xauthority` を適切に作成
# ======================================================================
echo "📌 `.Xauthority` を作成..."
touch ~/.Xauthority
xauth generate :1 . trusted

# ======================================================================
# `.Xresources` の設定を作成 & 適用
# ======================================================================
echo "📌 `.Xresources` を設定..."
cat <<EOF > ~/.Xresources
Xft.dpi: 96
Xcursor.theme: Adwaita
EOF
xrdb ~/.Xresources

# ======================================================================
# VNC の初回設定（パスワード設定: userland）
# ======================================================================
echo "📌 VNC のパスワードを userland に設定..."
mkdir -p ~/.vnc
echo "userland" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# ======================================================================
# VNC の xstartup 設定（XFCE4 を起動）
# ======================================================================
echo "📌 VNC の xstartup を XFCE4 に設定..."
cat <<EOF > ~/.vnc/xstartup
#!/bin/bash
export DISPLAY=:1
xrdb \$HOME/.Xresources
dbus-launch --exit-with-session startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

# ======================================================================
# VNC サーバーの起動（エラー時はデバッグ情報を出力）
# ======================================================================
echo "📌 VNC サーバーを起動（ポート: 5901）..."
vncserver -kill :1 &> /dev/null
vncserver :1 -geometry 1280x720 || {
    echo "❌ VNC の起動に失敗しました！デバッグ情報を表示します。"
    cat ~/.vnc/*.log
    exit 1
}

# ======================================================================
# 接続情報を表示
# ======================================================================
LOCAL_IP=$(hostname -I | awk '{print $1}')
echo "=========================================="
echo "🎉 VNC サーバーのセットアップが完了しました！"
echo "📌 接続情報: $LOCAL_IP:5901"
echo "🔑 VNC パスワード: userland"
echo "🖥️ VNC クライアントで接続してください！"
echo "✅ キーボードレイアウトは「日本語 (JP)」に設定済み"
echo "=========================================="
