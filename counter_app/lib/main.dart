import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Counter());
}

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  void _updateCounter(int increment) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + increment;
      prefs.setInt('counter', _counter);
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
                        child: Text('$_counter',
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
                        CustomIconButton(
                            onPressed: () => _updateCounter(1),
                            icon: Icons.add,
                            tooltip: 'Increment'),
                        CustomIconButton(
                            onPressed: () => _updateCounter(-1),
                            icon: Icons.remove,
                            tooltip: 'Decrement'),
                      ])
                ]),
          )),
        ));
  }
}

class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String tooltip;

  const CustomIconButton(
      {Key? key,
      required this.onPressed,
      required this.icon,
      required this.tooltip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: const Color(0xff043875), width: 3.0)),
        child: IconButton(
          iconSize: 42.0,
          icon: Icon(icon, color: const Color(0xff043875)),
          onPressed: () => onPressed(),
          tooltip: tooltip,
        ));
  }
}
