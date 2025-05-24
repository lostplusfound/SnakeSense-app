import 'package:flutter/material.dart';
import 'package:is_it_poisonous/classify_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Is it Poisonous?')),
      body: ClassifyScreen()
    );
  }
}
