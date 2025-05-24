import 'package:cross_file/cross_file.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:is_it_poisonous/onnx_predictor.dart';
import 'package:is_it_poisonous/prediction_card.dart';
import 'package:is_it_poisonous/species.dart';

class PredictionScreen extends StatefulWidget {
  final XFile _imageFile;

  const PredictionScreen(this._imageFile, {super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  static final List<Species> _speciesList = [];
  Uint8List? _imageBytes;
  Species? _predictedSpecies;

  @override
  void initState() {
    super.initState();
    _getPrediction(widget._imageFile);
  }

  Future<void> _loadSpecies() async {
    final csvString = await rootBundle.loadString('assets/csv/species.csv');
    List<List<dynamic>> rows = const CsvToListConverter(
      textDelimiter: null,
      eol: '\n',
    ).convert(csvString).sublist(1);
    for (List<dynamic> row in rows) {
      _speciesList.add(Species.fromCsvRow(row));
    }
    setState(() {});
  }

  Future<void> _getPrediction(XFile image) async {
    if (_speciesList.isEmpty) {
      await _loadSpecies();
    }
    _imageBytes = await image.readAsBytes();
    List preds = await OnnxPredictor.predict(_imageBytes!);
    int predictedIndex = 0;
    for (int i = 0; i < preds.length; i++) {
      if (preds[i] > preds[predictedIndex]) predictedIndex = i;
    }
    _predictedSpecies = _speciesList[predictedIndex];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Species Predictor')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _imageBytes != null && _predictedSpecies != null
                  ? PredictionCard(_imageBytes!, _predictedSpecies!)
                  : Column(
                    spacing: 8.0,
                    children: [
                      Text(
                        'Generating prediction...',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      LinearProgressIndicator(),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
