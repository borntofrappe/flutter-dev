import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wheels(),
    );
  }
}

class Wheels extends StatelessWidget {
  final int _columns = 3;
  final int _rows = 10;

  const Wheels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List<Widget>.generate(
                _columns,
                (index) => Expanded(
                    child: Center(
                        child: ListWheelScrollView.useDelegate(
                            itemExtent: 200.0,
                            childDelegate: ListWheelChildLoopingListDelegate(
                                children: List<Widget>.generate(
                              _rows,
                              (i) => FittedBox(
                                  fit: BoxFit.cover,
                                  child: Center(child: Text('$i'))),
                            ))))))));
  }
}
