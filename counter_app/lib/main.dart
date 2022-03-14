import 'package:flutter/material.dart';
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

  Color color = const Color(0xff043875);

  LinearGradient linearGradient = const LinearGradient(
      colors: [Color(0xffc6bafa), Color(0xffefbad7)],
      stops: [0.7, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Counter',
        home: Scaffold(
            body: Container(
          decoration: BoxDecoration(gradient: linearGradient),
          child: SafeArea(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: Text('Counter',
                        style: TextStyle(
                            color: color,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Ubuntu')),
                  ),
                  Expanded(
                    child: Center(
                        child: Text('$_counter',
                            style: TextStyle(
                                color: color,
                                fontSize: 256.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Ubuntu'))),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: color, width: 4.0),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                                iconSize: 52.0,
                                icon: Icon(
                                  Icons.remove,
                                  color: color,
                                  semanticLabel: 'Decrement',
                                ),
                                onPressed: () => _updateCounter(-1)),
                          ),
                          Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: color, width: 4.0),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                  iconSize: 52.0,
                                  icon: Icon(Icons.add,
                                      color: color, semanticLabel: 'Increment'),
                                  onPressed: () => _updateCounter(1)))
                        ],
                      ),
                    ),
                  )
                ]),
          )),
        )));
  }
}
