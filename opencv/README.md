# OpenCV インストールスクリプト集（UserLAnd 向け）

![タイトル画像](readme/header.png)

このリポジトリには **UserLAnd 環境で OpenCV をインストールするためのシェルスクリプト** が含まれています。  
**GUI 版 / CUI 版（Headless） / 最新版のコンパイル** に対応しています。

---

## 📌 スクリプト一覧
| ファイル名 | 説明 | GUI / CUI | インストール方法 |
|------------|------|-----------|------------------|
| `install_opencv_gui.sh` | **パッケージ版 OpenCV GUI** | GUI | `apt install python3-opencv` |
| `install_opencv_gui_latest.sh` | **最新の OpenCV GUI（ソースコンパイル）** | GUI | `git clone & build` |
| `install_opencv_cui.sh` | **パッケージ版 OpenCV Headless（CUI）** | CUI | `pip install opencv-python-headless` |
| `install_opencv_cui_latest.sh` | **最新の OpenCV Headless（ソースコンパイル）** | CUI | `git clone & build` |

---

## 🚀 **スクリプトの使い方**
### **1️⃣ GUI 版 OpenCV のインストール**
#### **(A) 簡単にインストール（パッケージ版）**
```bash
bash install_opencv_gui.sh
```
- **GUI あり**（`cv2.imshow()` などのウィンドウ操作が可能）
- `apt install` で簡単にインストール
- **手軽に OpenCV を使いたい方向け**

#### **(B) 最新版をコンパイル**
```bash
bash install_opencv_gui_latest.sh
```
- 最新の OpenCV を **GitHub から取得しコンパイル**
- より新しい機能を使用可能
- **最適化 & 高速化した環境を構築**

---

### **2️⃣ CUI 版（Headless）OpenCV のインストール**
#### **(A) 簡単にインストール（パッケージ版）**
```bash
bash install_opencv_cui.sh
```
- **GUI なしの軽量版**（`cv2.imshow()` なし）
- サーバーや CUI 環境向け
- **`pip install` で簡単にインストール可能**

#### **(B) 最新版をコンパイル**
```bash
bash install_opencv_cui_latest.sh
```
- **最新の OpenCV Headless を GitHub から取得しコンパイル**
- GUI を排除しつつ、高速化した環境を構築
- **CUI 環境での最適化 & 機械学習向け**

---

## 📌 まとめ
| スクリプト | 目的 | インストール方法 |
|------------|------|------------------|
| **`install_opencv_gui.sh`** | GUI 版 OpenCV を簡単にインストール | `apt install` |
| **`install_opencv_gui_latest.sh`** | 最新の GUI 版 OpenCV をコンパイル | `git clone & build` |
| **`install_opencv_cui.sh`** | 軽量な OpenCV Headless を簡単にインストール | `pip install` |
| **`install_opencv_cui_latest.sh`** | 最新の Headless 版 OpenCV をコンパイル | `git clone & build` |

🚀 **すべてのスクリプトが正常に動作すると、UserLAnd で OpenCV を自由に使える環境が整います！**

![タイトル画像](readme/footer.png)
