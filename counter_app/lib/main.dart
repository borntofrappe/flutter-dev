import 'package:flutter/material.dart';

void main() {
  runApp(const Counter());
}

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Counter',
        home: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const Text('Counter'),
              Text('$count'),
              Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            count += 1;
                          });
                        },
                        label: const Text('Increment')),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          count -= 1;
                        });
                      },
                      label: const Text('Decrement'),
                    )
                  ])
            ])));
  }
}
