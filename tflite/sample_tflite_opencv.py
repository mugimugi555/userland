import cv2
import numpy as np
import tflite_runtime.interpreter as tflite

# モデルとラベルをダウンロード（事前に実行）
MODEL_PATH = "mobilenet_v1_1.0_224_quant.tflite"
LABELS_PATH = "labels.txt"

# TFLite モデルのロード
interpreter = tflite.Interpreter(model_path=MODEL_PATH)
interpreter.allocate_tensors()

# 入出力の情報を取得
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# 画像の読み込みと前処理
image = cv2.imread("sample.jpg")
image = cv2.resize(image, (224, 224))
image = np.expand_dims(image, axis=0)
image = np.array(image, dtype=np.uint8)

# 推論の実行
interpreter.set_tensor(input_details[0]['index'], image)
interpreter.invoke()
output_data = interpreter.get_tensor(output_details[0]['index'])

# 結果の表示
label_id = np.argmax(output_data)
labels = open(LABELS_PATH).read().strip().split("\n")
print("✅ 予測ラベル:", labels[label_id])
