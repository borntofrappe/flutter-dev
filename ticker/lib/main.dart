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
        home: Scaffold(
            body: SafeArea(child: Ticker(count: _count, onChange: _setCount))));
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

  final int _animationDuration = 250;
  final Curve _animationCurve = Curves.fastOutSlowIn;

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
          duration: Duration(milliseconds: _animationDuration),
          curve: _animationCurve);
    } while (index > 0 &&
        ((direction == -1 && _controllers[index].selectedItem == 1) ||
            (direction == 1 && _controllers[index].selectedItem == 0)));

    Future.delayed(Duration(milliseconds: _animationDuration), () {
      _save();
    });
  }

  void _scrollToCount(count) {
    int index = _controllers.length - 1;
    int previousDigits = 0;

    while (index >= 0) {
      int digit = count % 10;

      FixedExtentScrollController _controller = _controllers[index];
      _controller.jumpToItem(digits);

      Future.delayed(
          Duration(milliseconds: _animationDuration * previousDigits), () {
        _controller.animateToItem(digits - digit,
            duration: Duration(milliseconds: _animationDuration * digit),
            curve: _animationCurve);
      });

      previousDigits += digit > 1 ? digit - 1 : digit;
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

  final TextStyle _textStyle = const TextStyle(
      fontFamily: 'Heebo',
      fontWeight: FontWeight.bold,
      color: Color(0xFF272F43));

  final ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
      elevation: 8.0,
      fixedSize: const Size(68.0, 68.0),
      primary: const Color(0xff121a2f),
      shape: const CircleBorder());

  final Color _colorIcon = const Color(0xffdfe4f7);
  final double _sizeIcon = 32.0;

  @override
  Widget build(BuildContext context) {
    _scrollToCount(widget.count);

    return Container(
      decoration: const BoxDecoration(color: Color(0xffeff2fb)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 3,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _controllers
                        .map((_controller) => Expanded(
                              child: ListWheelScrollView(
                                  overAndUnderCenterOpacity: 0.0,
                                  controller: _controller,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemExtent: 200.0,
                                  children: List<Widget>.generate(
                                          digits + 1,
                                          (index) => FittedBox(
                                              child: Text(
                                                  (index % digits).toString(),
                                                  style: _textStyle)))
                                      .reversed
                                      .toList()),
                            ))
                        .toList())),
            Expanded(
              flex: 1,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        child: Icon(Icons.remove,
                            semanticLabel: 'Count down',
                            size: _sizeIcon,
                            color: _colorIcon),
                        onPressed: () => _scroll(1),
                        style: _buttonStyle),
                    ElevatedButton(
                        child: Icon(Icons.add,
                            semanticLabel: 'Count up',
                            size: _sizeIcon,
                            color: _colorIcon),
                        onPressed: () => _scroll(-1),
                        style: _buttonStyle),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
