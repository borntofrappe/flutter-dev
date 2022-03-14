import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _getCounter() async {
    final instance = await SharedPreferences.getInstance();
    setState(() {
      _counter = instance.getInt('counter') ?? 0;
    });
  }

  void _updateCounter(int delta) async {
    final instance = await SharedPreferences.getInstance();
    setState(() {
      _counter = (instance.getInt('counter') ?? 0) + delta;
      instance.setInt('counter', _counter);
    });
  }

  @override
  void initState() {
    super.initState();

    _getCounter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Counter',
        home: Scaffold(
            body: SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Text('$_counter'),
              Row(
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.remove,
                        semanticLabel: 'Decrement',
                      ),
                      onPressed: () => _updateCounter(-1)),
                  IconButton(
                      icon: const Icon(Icons.add, semanticLabel: 'Increment'),
                      onPressed: () => _updateCounter(1))
                ],
              )
            ]))));
  }
}
