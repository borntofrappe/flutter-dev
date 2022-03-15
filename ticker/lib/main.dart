import 'package:flutter/material.dart';

void main() {
  runApp(const Ticker());
}

const digits = 10;

class Ticker extends StatelessWidget {
  const Ticker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ticker',
        home: Scaffold(
            body: ListWheelScrollView(
                itemExtent: 200.0,
                children: List<Widget>.generate(
                    digits, (index) => FittedBox(child: Text(('$index')))))));
  }
}
