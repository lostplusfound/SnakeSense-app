import 'package:cross_file/cross_file.dart';
import 'package:flutter/services.dart';
import 'onnx_predictor.dart';
import 'species.dart';
import 'package:csv/csv.dart';

class SpeciesPredictor {
  static final List<Species> _speciesList = [];

  static Future<void> _loadSpecies() async {
    final csvString = await rootBundle.loadString('assets/species.csv');
    List<List<dynamic>> rows = const CsvToListConverter().convert(csvString);
    for (List<dynamic> row in rows) {
      _speciesList.add(Species.fromCsvRow(row));
    }
  }

  static Future<Species> getPrediction(XFile image) async {
    if (_speciesList.isEmpty) {
      await _loadSpecies();
    }
    List preds = await OnnxPredictor.predict(image);
    int predictedIndex = 0;
    for (int i = 0; i < preds.length; i++) {
      if (preds[i] > preds[predictedIndex]) predictedIndex = i;
    }
    return _speciesList[predictedIndex];
  }
}
