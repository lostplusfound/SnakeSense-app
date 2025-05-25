import 'package:flutter/material.dart';
import 'package:is_it_poisonous/classify_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            AboutListTile(
              applicationName: 'SnakeSense',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2025 lostplusfound',
              aboutBoxChildren: [
                TextButton(
                  onPressed: () async {
                    if (await canLaunchUrlString('https://github.com/lostplusfound/SnakeSense-app')) {
                      await launchUrlString('https://github.com/lostplusfound/SnakeSense-app');
                    } else {
                      if(context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Could not open the link.'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      }
                    }
                  },

                  child: Text('Github Repository'),
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(title: Text('SnakeSense')),
      body: ClassifyScreen(),
    );
  }
}
