import 'dart:io';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:is_it_poisonous/species.dart';
import 'package:is_it_poisonous/species_predictor.dart';

class PredictionScreen extends StatefulWidget {
  final XFile _image;

  const PredictionScreen(this._image, {super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  Uint8List? _imageBytes;
  Species? _predictedSpecies;

  @override
  void initState() {
    super.initState();
    _loadImage();
    _predictSpecies();
  }

  void _loadImage() async {
    _imageBytes = await widget._image.readAsBytes();
    setState(() {});
  }

  void _predictSpecies() async {
    _predictedSpecies = await SpeciesPredictor.getPrediction(widget._image);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Species Predictor')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _imageBytes != null
                ? Image.memory(
                  _imageBytes!,
                  height: MediaQuery.of(context).size.height / 2,
                )
                : CircularProgressIndicator(),
            _predictedSpecies != null
                ? Text(_predictedSpecies!.commonName)
                : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
