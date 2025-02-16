# TensorFlow Lite + OpenCV 環境構築 & サンプル実行

![タイトル画像](readme/header.png)

このリポジトリには **TensorFlow Lite（TFLite）と OpenCV を UserLAnd 環境でインストールし、サンプルを実行するためのスクリプト** が含まれています。

---

## 📌 スクリプト一覧
| ファイル名 | 説明 |
|------------|------|
| `install_tflite.sh` | TensorFlow Lite のみをインストール |
| `install_tflite_opencv.sh` | TensorFlow Lite + OpenCV をインストール |
| `sample_tflite_opencv.py` | TFLite + OpenCV で画像分類を実行するサンプル |
| `sample_tflite_opencv.sh` | サンプルコードの実行 & 必要なモデルのダウンロード |

---

## 🚀 **インストール手順**
### **1️⃣ TensorFlow Lite のみをインストール**
```bash
bash install_tflite.sh
```
- **TFLite のみを導入したい場合に実行**
- `tflite-runtime` をインストール

### **2️⃣ TensorFlow Lite + OpenCV をインストール**
```bash
bash install_tflite_opencv.sh
```
- **TFLite + OpenCV の両方をインストール**
- 画像処理に必要な `opencv-python-headless` も導入

---

## 🏃 **サンプルコードの実行**
### **1️⃣ 必要なモデル & 画像の取得**
```bash
bash sample_tflite_opencv.sh
```
- **モデル (`mobilenet_v1_1.0_224_quant.tflite`) を自動ダウンロード**
- **ラベル (`labels.txt`) を取得**
- **サンプル画像 (`sample.jpg`) を取得**

### **2️⃣ TFLite + OpenCV で画像分類を実行**
```bash
python3 sample_tflite_opencv.py
```
- MobileNet を使用した **画像分類** を実行
- 予測ラベル（分類結果）を表示

---

## **✅ まとめ**
| スクリプト | 目的 |
|------------|------|
| **`install_tflite.sh`** | TensorFlow Lite のみをインストール |
| **`install_tflite_opencv.sh`** | TensorFlow Lite + OpenCV をインストール |
| **`sample_tflite_opencv.sh`** | モデル・画像をダウンロード |
| **`sample_tflite_opencv.py`** | 画像分類のサンプルコード |

🚀 **これらのスクリプトを実行すれば、TFLite + OpenCV を簡単に動作確認できます！**

![タイトル画像](readme/footer.png)
