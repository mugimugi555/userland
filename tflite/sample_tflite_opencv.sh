#!/bin/bash

echo "======================================"
echo "🚀 TensorFlow Lite モデル取得 & サンプル実行スクリプト"
echo "======================================"

# モデル & ラベルの URL
MODEL_URL="https://storage.googleapis.com/tfhub-lite-models/tensorflow/lite-model/mobilenet_v1_1.0_224_quant/1/default/1.tflite"
LABELS_URL="https://storage.googleapis.com/download.tensorflow.org/data/imagenet_labels.txt"

# モデル & ラベルの保存先
MODEL_PATH="mobilenet_v1_1.0_224_quant.tflite"
LABELS_PATH="labels.txt"

# 画像のサンプル（テスト用）
SAMPLE_IMAGE="sample.jpg"
SAMPLE_IMAGE_URL="https://upload.wikimedia.org/wikipedia/commons/2/26/YellowLabradorLooking_new.jpg"

# Python サンプルスクリプト（事前に作成済み）
PYTHON_SCRIPT="sample_tflite_opencv.pyy"

# ======================================================================
# モデルのダウンロード（なければ取得）
# ======================================================================
if [ ! -f "$MODEL_PATH" ]; then
    echo "📌 TensorFlow Lite モデルをダウンロード中..."
    wget -O "$MODEL_PATH" "$MODEL_URL"
else
    echo "✅ モデルファイルは既に存在します。"
fi

# ラベルのダウンロード（なければ取得）
if [ ! -f "$LABELS_PATH" ]; then
    echo "📌 ラベルファイルをダウンロード中..."
    wget -O "$LABELS_PATH" "$LABELS_URL"
else
    echo "✅ ラベルファイルは既に存在します。"
fi

# 画像のダウンロード（なければ取得）
if [ ! -f "$SAMPLE_IMAGE" ]; then
    echo "📌 サンプル画像をダウンロード中..."
    wget -O "$SAMPLE_IMAGE" "$SAMPLE_IMAGE_URL"
else
    echo "✅ サンプル画像は既に存在します。"
fi

# ======================================================================
# Python サンプルスクリプトの実行
# ======================================================================
if [ -f "$PYTHON_SCRIPT" ]; then
    echo "📌 TFLite 推論を実行中..."
    python3 "$PYTHON_SCRIPT"
else
    echo "❌ エラー: Python サンプルスクリプト ($PYTHON_SCRIPT) が見つかりません。"
    exit 1
fi

echo "======================================"
echo "🎉 TFLite サンプル実行が完了しました！"
echo "======================================"
