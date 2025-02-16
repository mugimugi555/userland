# UserLAnd 環境向けインストールスクリプト集

このリポジトリには、**UserLAnd 環境で LAMP, Nginx, PHP, Laravel, Rails, WordPress などをインストールするためのスクリプト** が含まれています。

---

## 📌 スクリプト一覧

| ファイル名                     | 説明 |
|--------------------------------|------|
| `install_crond_service.sh`     | cron サービスを設定し、MySQL, Apache2, Nginx, PHP-FPM などの自動起動を有効化 |
| `install_lamp.sh`              | Apache2 + MySQL + PHP（LAMP 環境）をインストール |
| `install_laravel.sh`           | Laravel をインストールし、環境をセットアップ |
| `install_nginx.sh`             | 最新の Nginx をインストールし、ポートをカスタマイズ可能に設定 |
| `install_nginx_php.sh`         | Nginx + PHP-FPM をインストールし、Nginx で PHP を動作させる設定を適用 |
| `install_php.sh`               | 最新の PHP をインストールし、必要なモジュールをセットアップ |
| `install_rails.sh`             | Ruby on Rails をインストールし、Node.js や Yarn もセットアップ |
| `install_wordpress.sh`         | WordPress をインストールし、データベースのセットアップも実施 |

---

## 🚀 **インストール手順**
### **1️⃣ cron サービスを有効化（MySQL, Apache2, Nginx, PHP-FPM を自動起動）**
```bash
bash install_crond_service.sh
```
- **インストール済みのサービスを検出し、cron に登録**
- **UserLAnd のセッション起動時に Web サーバーを自動起動**

### **2️⃣ LAMP 環境を構築（Apache2 + MySQL + PHP）**
```bash
bash install_lamp.sh
```
- **Apache2 をポート 8080 に設定**
- **MySQL をセットアップし、データベースを作成**

### **3️⃣ Laravel をインストール**
```bash
bash install_laravel.sh
```
- **Composer を使用して Laravel プロジェクトを作成**
- **必要な PHP モジュールをセットアップ**

### **4️⃣ Nginx のインストール（ポート変更可能）**
```bash
bash install_nginx.sh
```
- **Nginx をインストールし、ポート 8081 に変更**
- **UserLAnd 環境向けの最適な設定を適用**

### **5️⃣ Nginx + PHP-FPM をセットアップ**
```bash
bash install_nginx_php.sh
```
- **Nginx で PHP を動作させる設定を適用**
- **PHP-FPM を起動し、Nginx と連携**

### **6️⃣ 最新の PHP をインストール**
```bash
bash install_php.sh
```
- **最新の PHP と各種拡張モジュール（MySQL, XML, mbstring, etc.）をインストール**

### **7️⃣ Ruby on Rails をセットアップ**
```bash
bash install_rails.sh
```
- **rbenv を使用して Ruby をインストール**
- **Rails の環境をセットアップし、データベースを構築**

### **8️⃣ WordPress をインストール**
```bash
bash install_wordpress.sh
```
- **最新の WordPress をダウンロードし、セットアップ**
- **MySQL にデータベースを作成し、WordPress を動作可能にする**

---

## ✅ **まとめ**
| スクリプト | 目的 |
|------------|------|
| **install_crond_service.sh** | cron を設定し、MySQL / Apache2 / Nginx / PHP-FPM を自動起動 |
| **install_lamp.sh** | Apache2 + MySQL + PHP（LAMP）をインストール |
| **install_laravel.sh** | Laravel をインストールし、環境をセットアップ |
| **install_nginx.sh** | 最新の Nginx をインストール（ポート変更可能） |
| **install_nginx_php.sh** | Nginx + PHP-FPM をセットアップし、PHP を動作可能にする |
| **install_php.sh** | 最新の PHP と拡張モジュールをインストール |
| **install_rails.sh** | Ruby on Rails をセットアップし、動作確認まで実施 |
| **install_wordpress.sh** | WordPress をインストールし、データベースをセットアップ |

🚀 **これらのスクリプトを実行すれば、UserLAnd で Web サーバー環境をすぐに構築できます！**

