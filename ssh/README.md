# UserLAnd で SSH を設定する手順

![タイトル画像](readme/header.png)

このリポジトリには **UserLAnd 環境で SSH 接続を有効化するためのシェルスクリプト** が含まれています。  
以下の手順で **SSH キーの作成、アップロード、設定、IP 確認、ログインテスト** を行うことで、Android 上の UserLAnd に SSH 接続が可能になります。

---

## 📌 手順
UserLAnd のセッションを起動し、以下の順番でスクリプトを実行してください。

### 1️⃣ SSH キーを作成
```bash
bash 1_create_my_sshkey.sh
```
#### 📌 このスクリプトの内容
- `~/.ssh/android_id_rsa`（秘密鍵）と `~/.ssh/android_id_rsa.pub`（公開鍵）を作成
- 既存のキーがある場合は上書きせずにスキップ

---

### 2️⃣ SSH 公開鍵を Android 端末にアップロード
```bash
bash 2_upload_my_sskey.sh
```
#### 📌 このスクリプトの内容
- ADB を使用して Android 端末の `/data/local/tmp/` に `android_id_rsa.pub` を転送
- 転送後、`adb shell cat` を使って正しく転送されたか確認

---

### 3️⃣ SSH キーを有効化
```bash
bash 3_enable_sshkey.sh
```
#### 📌 このスクリプトの内容
- UserLAnd 内で SSH キーをセットアップ
- `~/.ssh/authorized_keys` に公開鍵を追加
- `.ssh` ディレクトリのパーミッションを適切に設定

---

### 4️⃣ IP アドレスを取得
```bash
bash 4_get_ipaddress.sh
```
#### 📌 このスクリプトの内容
- ADB 経由で Android 端末の IP アドレスを取得
- IP アドレスを一覧表示

---

### 5️⃣ SSH ログインの確認
```bash
bash 5_check_ssh_login.sh
```
#### 📌 このスクリプトの内容
- SSH キーを使用して、UserLAnd に SSH ログインを試行
- 成功・失敗の結果を表示

---

## ✅ 確認方法
### SSH 接続を手動でテスト
スクリプトを実行した後、取得した IP アドレスを使って **手動で SSH 接続を試す** こともできます。

```bash
ssh -i ~/.ssh/android_id_rsa userland@<取得したIPアドレス>
```

🚀 **すべてのスクリプトが正常に動作すると、UserLAnd に SSH 接続できるようになります！**

---

## 📌 まとめ
| スクリプト | 目的 | 実行コマンド |
|-----------|------|--------------|
| **1_create_my_sshkey.sh** | SSH キーの作成 | `bash 1_create_my_sshkey.sh` |
| **2_upload_my_sskey.sh** | SSH 公開鍵を Android に転送 | `bash 2_upload_my_sskey.sh` |
| **3_enable_sshkey.sh** | UserLAnd 内で SSH キーを有効化 | `bash 3_enable_sshkey.sh` |
| **4_get_ipaddress.sh** | IP アドレスの取得 | `bash 4_get_ipaddress.sh` |
| **5_check_ssh_login.sh** | SSH ログインの確認 | `bash 5_check_ssh_login.sh` |

✅ **これで UserLAnd に SSH 接続できる環境が完成します！ 🚀**

![タイトル画像](readme/footer.png)