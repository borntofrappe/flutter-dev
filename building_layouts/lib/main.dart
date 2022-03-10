import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Building layouts',
        home: Scaffold(
            appBar: AppBar(title: const Text('Building layouts')),
            body: const Center(child: Text('Hello World'))));
  }
}
