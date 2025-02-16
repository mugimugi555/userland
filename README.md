# UserLAnd 環境向けインストールスクリプト集

このリポジトリには、**UserLAnd 環境で CUI / GUI のセットアップ、日本語環境の設定、XFCE4 デスクトップ環境のインストールを行うためのスクリプト** が含まれています。

---

## 📌 フォルダ構成

```
/
├── opencv/       # OpenCV 関連スクリプト
├── server/       # Web サーバー関連スクリプト (Apache, Nginx, PHP, MySQL, etc.)
├── ssh/          # SSH 設定関連スクリプト
├── tflite/       # TensorFlow Lite 関連スクリプト
├── install_for_cui.sh   # CUI 環境向けセットアップスクリプト
├── install_for_gui.sh   # GUI 環境向けセットアップスクリプト
├── install_jp.sh        # 日本語環境を設定するスクリプト
├── install_xfce4.sh     # XFCE4 デスクトップ環境をインストールするスクリプト
```

---

## 🚀 **インストール手順**

### **1️⃣ CUI 環境のセットアップ**
```bash
bash install_for_cui.sh
```
- 必要なコマンドラインツールをインストール
- 一般的なユーティリティをセットアップ

### **2️⃣ GUI 環境のセットアップ**
```bash
bash install_for_gui.sh
```
- GUI 環境に必要なパッケージをインストール
- 追加のツールを導入

### **3️⃣ 日本語環境の設定**
```bash
bash install_jp.sh
```
- `ja_JP.UTF-8` のロケールを設定
- フォントをインストール
- 日本語環境を有効化

### **4️⃣ XFCE4 デスクトップ環境のインストール**
```bash
bash install_xfce4.sh
```
- `xfce4` をインストール
- `VNC` をセットアップし、GUI 環境を起動

---

## ✅ **まとめ**

| スクリプト | 目的 |
|------------|------|
| **install_for_cui.sh** | CUI 環境向けの基本ツールをインストール |
| **install_for_gui.sh** | GUI 環境向けのツールをインストール |
| **install_jp.sh** | 日本語環境をセットアップ |
| **install_xfce4.sh** | XFCE4 をインストールし、VNC で GUI を有効化 |

🚀 **これらのスクリプトを実行すれば、UserLAnd で快適な環境を構築できます！**

