import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:cross_file/cross_file.dart';
import 'package:flutter_onnxruntime/flutter_onnxruntime.dart';

class OnnxPredictor {
  static Float32List _preprocess(img.Image image) {
    final resized = img.copyResize(image, width: 224, height: 224);
    const mean = [0.485, 0.456, 0.406];
    const std = [0.229, 0.224, 0.225];
    final Float32List input = Float32List(
      1 * 3 * 224 * 224,
    ); 
    for (int y = 0; y < 224; y++) {
      for (int x = 0; x < 224; x++) {
        final pixel = resized.getPixel(x, y);
        final r = pixel.rNormalized;
        final g = pixel.gNormalized;
        final b = pixel.bNormalized;
        final i = y * 224 + x;
        input[i] = (r - mean[0]) / std[0]; 
        input[224 * 224 + i] = (g - mean[1]) / std[1];
        input[2 * 224 * 224 + i] = (b - mean[2]) / std[2];
      }
    }

    return input;
  }

  static Future<List> predict(XFile imageFile) async {
    final ort = OnnxRuntime();
    final session = await ort.createSessionFromAsset(
      'assets/models/model.onnx',
    );
    final shape = [1, 3, 224, 224];
    final img.Image? image = await img.decodeImageFile(imageFile.path);
    final inputs = {
      'inputs': await OrtValue.fromList(_preprocess(image!), shape),
    };
    final outputs = await session.run(inputs);
    final preds = await outputs['output']?.asList();
    return preds?[0] ?? [];
  }
}