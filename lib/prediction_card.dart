import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:is_it_poisonous/species.dart';

class PredictionCard extends StatelessWidget {
  final Uint8List _imageBytes;
  final Species _prediction;

  const PredictionCard(this._imageBytes, this._prediction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Predicted Species',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Image.memory(
              _imageBytes,
              height: MediaQuery.of(context).size.height / 2,
            ),
            const SizedBox(height: 16),

            Text(
              _prediction.commonName,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              _prediction.binomialName,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            Text('Genus: ${_prediction.genus}'),
            Text('Family: ${_prediction.family}'),
            Text('Subfamily: ${_prediction.snakeSubFamily}'),
            Text('Region: ${_prediction.country}, ${_prediction.continent}'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _prediction.poisonous
                    ? Icon(Icons.warning, color: Colors.red)
                    : Icon(Icons.check, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  _prediction.poisonous ? 'Poisonous' : 'Non-poisonous',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        _prediction.poisonous ? Colors.red : Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Text(
              'This app uses AI predictions and may not always be accurate. Do not rely solely on this result for safety decisions. '
              'If you are bitten by a snake, seek immediate medical attention.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
