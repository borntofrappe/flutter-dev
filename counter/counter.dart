import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Counter(),
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _updateCounter(int change) {
    setState(() {
      _counter += change;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Value: $_counter',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _updateCounter(1),
            ),
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => _updateCounter(-1),
            ),
          ],
        ),
      ],
    );
  }
}
