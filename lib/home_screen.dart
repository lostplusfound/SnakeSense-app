import 'package:flutter/material.dart';
import 'package:is_it_poisonous/classify_screen.dart';
import 'package:is_it_poisonous/history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> destinations = [ClassifyScreen(), HistoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Is it Poisonous?')),
      body: destinations[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.search), label: 'Classify'),
          NavigationDestination(icon: Icon(Icons.update), label: 'History'),
        ],
      ),
    );
  }
}
