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
              showDialog(
                  context: context,
                  builder: (BuildContext context) => SimpleDialog(
                          title: const Text('Paint the town'),
                          children: <Widget>[
                            SimpleDialogOption(
                                child: const Text('Red'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Passion red')));
                                }),
                            SimpleDialogOption(
                                child: const Text('Green'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Life green')));
                                }),
                            SimpleDialogOption(
                                child: const Text('Blue'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Sky blue')));
                                })
                          ]));
            }));
  }
}
