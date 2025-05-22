import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:is_it_poisonous/prediction_screen.dart';

class ClassifyScreen extends StatefulWidget {
  const ClassifyScreen({super.key});

  @override
  State<ClassifyScreen> createState() => _ClassifyScreenState();
}

class _ClassifyScreenState extends State<ClassifyScreen> {
  final _imagePicker = ImagePicker();

  Future<XFile?> _pickImage(bool fromGallery) async {
    return await _imagePicker.pickImage(
      source: fromGallery ? ImageSource.gallery : ImageSource.camera,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 10.0,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: () async {
              final XFile? image = await _pickImage(true);
              if (image != null && context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PredictionScreen(image),
                  ),
                );
              }
            },
            child: Text('Select Image'),
          ),
          Text('Or'),
          OutlinedButton(
            onPressed: () async {
              final XFile? image = await _pickImage(false);
              if (image != null && context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PredictionScreen(image),
                  ),
                );
              }
            },
            child: Text('Take a Photo'),
          ),
        ],
      ),
    );
  }
}
