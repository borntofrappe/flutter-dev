import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'About Dialog',
    home: App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(color: Colors.grey[100]),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.mode_comment_rounded),
            onPressed: () {
              showAboutDialog(context: context, children: [
                const Text('A trivial widget'),
                const SizedBox(height: 8.0),
                const Text('Dated March 24th. A Thursday of all days.'),
              ]);
            }));
  }
}
