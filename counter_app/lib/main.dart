import 'package:flutter/material.dart';
import 'dart:math';

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
        home: Scaffold(
          body: SafeArea(
              child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    stops: [0.7, 1],
                    colors: [Color(0xffc6bafa), Color(0xffefbad7)],
                    transform: GradientRotation(pi / 2))),
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Counter',
                    style: TextStyle(
                        color: Color(0xff043875),
                        fontFamily: 'Ubuntu',
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('$count',
                            style: const TextStyle(
                                color: Color(0xff043875),
                                fontFamily: 'Ubuntu',
                                fontSize: 156.0,
                                fontWeight: FontWeight.bold)),
                      )),
                  Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Color(0xff043875), width: 3.0)),
                          child: IconButton(
                              focusColor: Colors.black54,
                              iconSize: 42.0,
                              icon: const Icon(Icons.add,
                                  color: Color(0xff043875)),
                              onPressed: () {
                                setState(() {
                                  count += 1;
                                });
                              },
                              tooltip: 'Increment'),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Color(0xff043875), width: 3.0)),
                          child: IconButton(
                            iconSize: 42.0,
                            icon: const Icon(Icons.remove,
                                color: Color(0xff043875)),
                            onPressed: () {
                              setState(() {
                                count -= 1;
                              });
                            },
                            tooltip: 'Decrement',
                          ),
                        )
                      ])
                ]),
          )),
        ));
  }
}
