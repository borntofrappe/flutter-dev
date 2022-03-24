import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
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
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                          title: const Text('Warning'),
                          content:
                              const Text('This dialog needs to be dismissed.'),
                          actions: [
                            TextButton(
                                child: const Text('Okay!'),
                                onPressed: () {
                                  Navigator.pop(context);
                                })
                          ]));
            }));
  }
}
