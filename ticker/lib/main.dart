import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const digits = 10;
const columns = 3;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _count = 0;

  void _getCount() async {
    final instance = await SharedPreferences.getInstance();
    setState(() {
      _count = instance.getInt('count') ?? 0;
    });
  }

  void _setCount(int count) async {
    final instance = await SharedPreferences.getInstance();
    instance.setInt('count', count);
  }

  @override
  void initState() {
    super.initState();

    _getCount();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ticker',
        home: Scaffold(body: Ticker(count: _count, onChange: _setCount)));
  }
}

class Ticker extends StatefulWidget {
  final int count;
  final Function onChange;
  const Ticker({Key? key, this.count = 0, required this.onChange})
      : super(key: key);

  @override
  State<Ticker> createState() => _TickerState();
}

class _TickerState extends State<Ticker> {
  final List<FixedExtentScrollController> _controllers =
      List<FixedExtentScrollController>.generate(
          columns, (_) => FixedExtentScrollController());

  void _save() {
    int count = 0;
    for (int i = 0; i < _controllers.length; i++) {
      count += ((digits - _controllers[i].selectedItem) % digits) *
          pow(10, _controllers.length - i - 1).toInt();
    }
    widget.onChange(count);
  }

  void _scroll(int direction) {
    int index = _controllers.length;
    do {
      index -= 1;

      if (direction == -1 && _controllers[index].selectedItem == 0) {
        _controllers[index].jumpToItem(digits);
      } else if (direction == 1 && _controllers[index].selectedItem == digits) {
        _controllers[index].jumpToItem(0);
      }

      _controllers[index].animateToItem(
          _controllers[index].selectedItem + 1 * direction,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutSine);
    } while (index > 0 &&
        ((direction == -1 && _controllers[index].selectedItem == 1) ||
            (direction == 1 && _controllers[index].selectedItem == 0)));

    Future.delayed(const Duration(milliseconds: 250), () {
      _save();
    });
  }

  void _scrollToCount(count) {
    int index = _controllers.length - 1;
    while (index >= 0) {
      int digit = count % 10;
      _controllers[index].jumpToItem(digits);

      _controllers[index].animateToItem(digits - digit,
          duration: Duration(milliseconds: 250 * digit),
          curve: Curves.easeInOutSine);

      count = count ~/ 10;
      index -= 1;
    }
  }

  @override
  void dispose() {
    super.dispose();

    for (FixedExtentScrollController _controller in _controllers) {
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    _scrollToCount(widget.count);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _controllers
                    .map((_controller) => Expanded(
                          child: ListWheelScrollView(
                              overAndUnderCenterOpacity: 1.0, // SET TO 0.0
                              controller: _controller,
                              physics: const NeverScrollableScrollPhysics(),
                              itemExtent: 200.0,
                              children: List<Widget>.generate(
                                      digits + 1,
                                      (index) => FittedBox(
                                          child: Text(
                                              (index % digits).toString())))
                                  .reversed
                                  .toList()),
                        ))
                    .toList())),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 48.0,
                icon: const Icon(Icons.remove),
                onPressed: () => _scroll(1),
              ),
              IconButton(
                iconSize: 48.0,
                icon: const Icon(Icons.add),
                onPressed: () => _scroll(-1),
              )
            ],
          ),
        )
      ],
    );
  }
}
