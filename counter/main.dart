import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void _getCounter() async {
    final instance = await SharedPreferences.getInstance();

    setState(() {
      _counter = instance.getInt('counter') ?? 0;
    });
  }

  void _updateCounter(int change) async {
    final instance = await SharedPreferences.getInstance();

    setState(() {
      _counter = (instance.getInt('counter') ?? 0) + change;
      instance.setInt('counter', _counter);
    });
  }

  @override
  void initState() {
    super.initState();

    _getCounter();
  }

  final _color = const Color(0xff043875);

  Widget _buildIconButton(
      IconData icon, String semanticLabel, Function onPressed) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: _color,
          width: 4.0,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        iconSize: 48.0,
        icon: Icon(
          icon,
          color: _color,
          semanticLabel: semanticLabel,
        ),
        onPressed: () => onPressed(),
      ),
    );
  }

  final LinearGradient _linearGradient = const LinearGradient(
    colors: [
      Color(0xffc6bafa),
      Color(0xffefbad7),
    ],
    stops: [0.7, 1],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: _linearGradient),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Text(
              'Counter',
              style: TextStyle(
                color: _color,
                fontSize: 48.0,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                '$_counter',
                style: TextStyle(
                  color: _color,
                  fontSize: 212.0,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 480.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildIconButton(
                    Icons.remove,
                    'Decrement',
                    () => _updateCounter(-1),
                  ),
                  _buildIconButton(
                    Icons.add,
                    'Increment',
                    () => _updateCounter(1),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
